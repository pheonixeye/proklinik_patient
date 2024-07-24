// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:patient/core/api/notifications_api.dart';
import 'package:patient/functions/debug_print.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:proklinik_models/models/booking_data.dart';
import 'package:proklinik_models/models/clinic.dart';
import 'package:proklinik_models/models/doctor.dart';
import 'package:proklinik_models/models/query_object.dart';
import 'package:proklinik_models/models/review.dart';
import 'package:proklinik_models/models/contact_us_model.dart';
import 'package:proklinik_models/models/server_response_model.dart';
import 'package:proklinik_models/models/sorting_model.dart';

class PocketbaseHelper {
  static final pb = PocketBase(const String.fromEnvironment("PB_SERVER").isEmpty
      ? "http://127.0.0.1:8090"
      : const String.fromEnvironment("PB_SERVER"));

  PocketbaseHelper();

  static Future<void> submitContactUsForm(ContactUsModel formModel) async {
    await pb.collection('contact_us').create(
          body: formModel.toJson(),
        );
    //todo: Send server notification to client who sent the message
    //todo: Send server notification to admin with sent message
  }

  static Future<Map<String, dynamic>> fetchClinicVisit({
    required String visit_id,
    required String visitsCollection,
  }) async {
    Map<String, dynamic>? data;
    try {
      final result = await pb.collection(visitsCollection).getOne(
            visit_id,
            expand: 'doc_id, clinic_id',
          );
      data = result.toJson();
      dprint('PocketbaseHelper().fetchClinicVisit(${data["id"]})');
      return data;
    } on ClientException catch (e) {
      dprint('PocketbaseHelper().fetchClinicVisit(${e.response['message']})');
      throw Exception(e.response['message']);
    }
  }

  static Future<void> updateClinicVisit({
    required String visit_id,
    required String visitsCollection,
    required Map<String, dynamic> update,
  }) async {
    await pb.collection(visitsCollection).update(
          visit_id,
          body: update,
        );
  }

  static Future<void> submitReview(Review review) async {
    //# submit review
    final result = await pb.collection('reviews').create(
          body: review.toJson(),
        );
    //# fetch doctor model after submitting the review
    final modelPreReviewRelation = await doctorProfileQuery(review.doc_id);

    final reviews = modelPreReviewRelation.reviews;
    final newReviewsRel = [...reviews.map((e) => e.id), result.id];

    await pb.collection('doctors').update(
      review.doc_id,
      body: {
        'review_rel': newReviewsRel,
      },
    );

    final modelPostReviewRelation = await doctorProfileQuery(review.doc_id);
    final reviewsPostRel = modelPostReviewRelation.reviews;

    //# update doctor model (rating) after adding the review
    final ratingList = reviewsPostRel.map<int>((e) => e.stars).toList();
    final averageRating =
        ratingList.fold<int>(0, (a, b) => a + b) / ratingList.length;
    await pb.collection('doctors').update(
      review.doc_id,
      body: {
        'rating': averageRating,
      },
    );
    //# update clinic model (waiting time) after adding the review
    final waitingTimeList =
        reviewsPostRel.map<int>((e) => e.waiting_time).toList();
    final averageWaitingTime =
        waitingTimeList.fold<int>(0, (a, b) => a + b) ~/ waitingTimeList.length;
    await pb.collection('clinics').update(
      review.clinic_rel,
      body: {
        'waiting_time': averageWaitingTime,
      },
    );
    //TODO: Send notification mail to doctor by the review
  }

  static Future<Review?> fetchReview(String visit_id) async {
    try {
      final result = await pb.collection('reviews').getFirstListItem(
            "visit_id = '$visit_id'",
          );
      final review = Review.fromJson(result.toJson());
      return review;
    } catch (e) {
      return null;
    }
  }

  static Future<void> updateDoctorProfileViews(String id, num views) async {
    await pb.collection("doctors").update(
      id,
      body: {
        "views": views + 1,
      },
    );
    dprint("PocketbaseHelper().updateDoctorProfileViews($id, $views)");
  }

  static String _dateBookingCollectionFormat(String date) {
    final d = DateTime.parse(date);
    return "visits_${d.month}_${d.year}";
  }

  static Future<BookingData?> sendBookingRequest(BookingData data) async {
    try {
      final bookResult = await pb
          .collection(_dateBookingCollectionFormat(data.date_time))
          .create(body: data.toPocketbaseJson());
      final bookingData = BookingData.fromPocketbaseJson(
        bookResult.toJson(),
        data.model,
      );
      //#send notification on booking
      NotificationsApi(bookingData: bookingData)
        ..sendSmsNotification()
        ..sendMailAndFcmNotification();
      return bookingData;
    } catch (e) {
      dprint("PocketbaseHelper().sendBookingRequest($e)");
      return null;
    }
  }

  static Future<ServerResponseModel> doctorProfileQuery(String id) async {
    final doctorData = await pb.collection("doctors").getOne(
          id,
          expand: "clinic_rel, review_rel",
        );
    final doctor = Doctor.fromJson(doctorData.toJson());
    //TODO: Show multiple doctor clinics with queried clinic selected
    final clinic =
        Clinic.fromJson(doctorData.expand["clinic_rel"]!.first.toJson());
    final reviews = (doctorData.expand["review_rel"] == null ||
            doctorData.expand["review_rel"]!.isEmpty)
        ? <Review>[]
        : doctorData.expand["review_rel"]!
            .map((r) => Review.fromJson(r.toJson()))
            .toList();
    reviews.sort(
      (a, b) => DateTime.parse(b.date_time).compareTo(
        DateTime.parse(a.date_time),
      ),
    );
    return ServerResponseModel(
      doctor: doctor,
      clinic: clinic,
      reviews: reviews,
      total: 1,
    );
  }

  static Future<List<ServerResponseModel>> mainQuery(QueryObject query) async {
    //todo: missing sorting && filter params
    //todo: filter by price(l300, m300), sort by price(l->h, h->l)
    //todo: sort by waiting time
    final List<ServerResponseModel> models = [];

    final queryString = query.toPocketbaseQuery();

    dprint(queryString);

    final doctorsData = await pb.collection("doctors").getList(
          page: int.parse(query.page),
          perPage: 10,
          expand: "clinic_rel, review_rel",
          filter: queryString.filter,
          sort: queryString.sort,
        );

    late final _WhichLocQuery whichLocQuery;

    doctorsData.items.map((d) {
      Clinic? clinic;
      final doctor = Doctor.fromJson(d.toJson());

      //#doctor didnot make a doctor profile yet
      if (d.expand["clinic_rel"] == null || d.expand["clinic_rel"]!.isEmpty) {
        return;
      }

      final clinicList = (d.expand["clinic_rel"] as List<RecordModel>)
          .map((e) => Clinic.fromJson(e.toJson()))
          .toList();

      //#filtering by area && gov
      if (query.city.isEmpty && query.gov.isEmpty) {
        whichLocQuery = _WhichLocQuery.noLocation;

        dprint("city & gov => empty");
        //TODO:
        clinic = clinicList.first;
      } else if (query.gov.isNotEmpty && query.city.isEmpty) {
        whichLocQuery = _WhichLocQuery.govOnly;

        dprint("gov => not Empty, city => empty");

        clinic = clinicList.firstWhere((cl) => cl.matchGov(query.gov));
      } else if (query.gov.isNotEmpty && query.city.isNotEmpty) {
        whichLocQuery = _WhichLocQuery.fullLocation;

        dprint("gov & city => not Empty");

        clinic = clinicList.firstWhere(
            (cl) => cl.matchGov(query.gov) && cl.matchArea(query.city));
      }
      final reviews =
          (d.expand["review_rel"] == null || d.expand["review_rel"]!.isEmpty)
              ? <Review>[]
              : d.expand["review_rel"]!
                  .map((r) => Review.fromJson(r.toJson()))
                  .toList();

      //#filter by availability
      if (query.availability != "any") {
        //todo: find which query was performed(noLocation, fullLocation, govOnly )
        switch (query.availability) {
          case "today":
            try {
              switch (whichLocQuery) {
                case _WhichLocQuery.noLocation:
                  clinic = clinicList
                      .firstWhere((cl) => cl.hasTodayAvailable == true);
                  break;
                case _WhichLocQuery.fullLocation:
                  clinic = clinicList.firstWhere((cl) =>
                      cl.hasTodayAvailable == true &&
                      cl.matchGov(query.gov) &&
                      cl.matchArea(query.city));
                  break;
                case _WhichLocQuery.govOnly:
                  clinic = clinicList.firstWhere((cl) =>
                      cl.hasTodayAvailable == true && cl.matchGov(query.gov));
                  break;
              }

              // dprint(clinic);
            } catch (e) {
              clinic = null;
            }
            break;
          case "tomorrow":
            try {
              switch (whichLocQuery) {
                case _WhichLocQuery.noLocation:
                  clinic = clinicList
                      .firstWhere((cl) => cl.hasTomorrowAvailable == true);
                  break;
                case _WhichLocQuery.fullLocation:
                  clinic = clinicList.firstWhere((cl) =>
                      cl.hasTomorrowAvailable == true &&
                      cl.matchGov(query.gov) &&
                      cl.matchArea(query.city));
                  break;
                case _WhichLocQuery.govOnly:
                  clinic = clinicList.firstWhere((cl) =>
                      cl.hasTomorrowAvailable == true &&
                      cl.matchGov(query.gov));
                  break;
              }
            } catch (e) {
              clinic = null;
            }
            break;
        }
      }

      if (clinic != null) {
        final model = ServerResponseModel(
          doctor: doctor,
          clinic: clinic,
          reviews: reviews,
          total: doctorsData.totalItems,
        );
        models.add(model);
      }
    }).toList();

    //todo: Clinic sorting(limitation: only the 10 results that came)
    //TODO: test it

    switch (SortingModelEnum.fromString(query.sort)) {
      //# sort by price
      case SortingModelEnum.priceHighToLow:
        models.sort((a, b) =>
            a.clinic.consultation_fees.compareTo(b.clinic.consultation_fees));
        break;
      //# sort by price
      case SortingModelEnum.priceLowToHigh:
        models.sort((a, b) =>
            b.clinic.consultation_fees.compareTo(a.clinic.consultation_fees));

        break;
      //# sort by waiting time
      case SortingModelEnum.waitingTime:
        models.sort(
            (a, b) => a.clinic.waiting_time.compareTo(b.clinic.waiting_time));

        break;
      case SortingModelEnum.empty:
        break;
    }

    //# sort by rating

    return models;
  }
}

enum _WhichLocQuery {
  noLocation,
  fullLocation,
  govOnly;
}
