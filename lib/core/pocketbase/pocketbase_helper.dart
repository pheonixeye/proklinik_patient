import 'dart:async';

import 'package:patient/constants/dummy_clinics.dart';
import 'package:patient/constants/dummy_doctors.dart';
import 'package:patient/constants/dummy_reviews.dart';
import 'package:patient/models/clinic.dart';
import 'package:patient/models/doctor.dart';
import 'package:patient/models/query_object.dart';
import 'package:patient/models/review.dart';
import 'package:patient/models/server_response_model.dart';
import 'package:pocketbase/pocketbase.dart';

class PocketbaseHelper {
  static final pb = PocketBase(const String.fromEnvironment("PB_SERVER").isEmpty
      ? "http://127.0.0.1:8090/"
      : const String.fromEnvironment("PB_SERVER"));

  PocketbaseHelper() {
    // addDoctors();
    // addClinics();
    // addReviews();
    // fetchAllDoctors();
    // testJsonQuery();
    // testNormalQuery();
    // updateReviewsRelation(); //#success
    // updateClinicDoctorRelation();
    // updateDoctorClinicReviewsRelation();
    // mainQuery(QueryObject.empty()); //#placeholder
  }

  static Future<ServerResponseModel> doctorProfileQuery(String id) async {
    final doctorData = await pb.collection("doctors").getOne(
          id,
          expand: "clinic_rel, review_rel",
        );
    final doctor = Doctor.fromJson(doctorData.toJson());
    final clinic =
        Clinic.fromJson(doctorData.expand["clinic_rel"]!.first.toJson());
    final reviews = doctorData.expand["review_rel"]!
        .map((r) => Review.fromJson(r.toJson()))
        .toList();
    return ServerResponseModel(
      doctor: doctor,
      clinic: clinic,
      reviews: reviews,
    );
  }

  static Future<List<ServerResponseModel>> mainQuery(QueryObject query) async {
    final List<ServerResponseModel> models = [];
    final doctorsData = await pb.collection("doctors").getList(
          expand: "clinic_rel, review_rel",
        );
    doctorsData.items.map((d) {
      final doctor = Doctor.fromJson(d.toJson());
      final clinic = Clinic.fromJson(d.expand["clinic_rel"]!.first.toJson());
      final reviews = d.expand["review_rel"]!
          .map((r) => Review.fromJson(r.toJson()))
          .toList();
      final model = ServerResponseModel(
        doctor: doctor,
        clinic: clinic,
        reviews: reviews,
      );
      models.add(model);
    }).toList();
    return models;
  }

  Future<void> updateDoctorClinicReviewsRelation() async {
    final doctorsData = await pb.collection("doctors").getList();
    final doctors =
        doctorsData.items.map((d) => Doctor.fromJson(d.toJson())).toList();
    doctors.map((doc) async {
      // final reviewsData = await pb.collection("reviews").getFullList(
      //       batch: 1000,
      //       filter: "field = '${doc.id}'",
      //     );

      // final reviews =
      //     reviewsData.map((e) => Review.fromJson(e.toJson())).toList();
      // await pb.collection('doctors').update(
      //   doc.id,
      //   body: {
      //     "review_rel": [...reviews.map((e) => e.id)],
      //   },
      // );

      final clinicData = await pb.collection("clinics").getList();
      final clinics =
          clinicData.items.map((e) => Clinic.fromJson(e.toJson())).toList();

      await pb.collection('doctors').update(
        doc.id,
        body: {
          "clinic_rel": [
            clinics.firstWhere((e) => (e.doc_id == doc.synd_id.toString())).id,
          ],
        },
      );
    }).toList();
  }

  Future<void> updateReviewsRelation() async {
    final doctorsData = await pb.collection("doctors").getList();
    final doctors =
        doctorsData.items.map((d) => Doctor.fromJson(d.toJson())).toList();
    print(doctors);
    final reviewsData = await pb.collection("reviews").getFullList(
          batch: 1500,
          filter: "field = ''",
        );
    final reviews =
        reviewsData.map((e) => Review.fromJson(e.toJson())).toList();
    reviews.map((x) async {
      final doctor =
          doctors.firstWhere((doc) => doc.synd_id == int.tryParse(x.doc_id));
      await pb.collection("reviews").update(
        x.id,
        body: {
          "field": doctor.id,
        },
      );
    }).toList();
  }

  Future<void> updateClinicDoctorRelation() async {
    final doctorsData = await pb.collection("doctors").getList();
    final doctors =
        doctorsData.items.map((d) => Doctor.fromJson(d.toJson())).toList();
    final clinicData = await pb.collection("clinics").getList();
    final clinics =
        clinicData.items.map((e) => Clinic.fromJson(e.toJson())).toList();
    clinics.map((c) async {
      final doctor =
          doctors.firstWhere((doc) => doc.synd_id.toString() == c.doc_id);
      await pb.collection("clinics").update(
        c.id,
        body: {
          "doc_rel": doctor.id,
        },
      );
    }).toList();
  }

  static Future<void> addDoctors() async {
    for (Doctor doctor in DOCTORS) {
      try {
        await pb.collection('doctors').create(body: doctor.toJson());
      } catch (e) {
        print(e.toString());
      }
    }
  }

  static Future<void> addClinics() async {
    for (final clinic in CLINICS) {
      await pb.collection('clinics').create(body: clinic.toJson());
    }
  }

  static Future<void> addReviews() async {
    for (final review in REVIEWS) {
      try {
        await pb.collection('reviews').create(body: review.toJson());
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<void> fetchAllDoctors() async {
    late final ResultList<RecordModel> results;
    late final List<Doctor> doctors;
    try {
      await pb.collection("doctors").getList().then((res) {
        // doctors =
        res.items.map((x) => Doctor.fromJson(x.toJson())).toList();
        // print(res.items.map((e) => e.toJson()).toList().first.entries.toList());
        // doctors.map((e) {
        //   print(e.name_en);
        // }).toList();
      });
    } catch (e, s) {
      print(s.toString());
      print(e);
    }
    try {
      // print(results);
      // doctors = results.items.map((x)=> x.data).toList();
    } catch (e) {
      print(e);
    }
  }

  Future<void> testJsonQuery() async {
    final result = await pb.collection("doctors").getList(
          filter: "destinations ~ 'Giza' && destinations ~ 'Haram'",
        );

    print(result);
  }

  Future<void> testNormalQuery() async {
    final result = await pb.collection("doctors").getList(
          filter:
              "(destinations.0.govEn = 'Giza' && destinations.0.areaEn = 'Haram') || (destinations.1.govEn = 'Giza' && destinations.1.areaEn = 'Haram')",
        );

    final result2 = await pb.collection("clinics").getList(
        // filter: "destination ~ 'Cairo' && destination ~ 'Rehab'",
        // sort: "-waiting_time",
        );
    // final waitingTimeList = result.items
    //     .map((e) => Clinic.fromJson(e.toJson()).waiting_time)
    //     .toList();
    // print(waitingTimeList);
    print(result);
  }
}
