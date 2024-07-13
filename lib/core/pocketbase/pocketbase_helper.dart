import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:patient/functions/debug_print.dart';
import 'package:patient/models/booking_data.dart';
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

  PocketbaseHelper();

  static Future<void> updateDoctorProfileViews(String id, int views) async {
    await pb.collection("doctors").update(
      id,
      body: {
        "views": views + 1,
      },
    );
    if (kDebugMode) {
      print("PocketbaseHelper().updateDoctorProfileViews($id, $views)");
    }
  }

  static String _dateBookingCollectionFormat(String date) {
    final d = DateTime.parse(date);
    return "visits_${d.month}_${d.year}";
  }

  static ({String userName, String password}) get _adminUserCredentials {
    return (
      userName: const String.fromEnvironment("ADMIN_USERNAME"),
      password: const String.fromEnvironment("ADMIN_PASSWORD")
    );
  }

  static Future<Map<String, dynamic>> _bookingCollectionSchema(
      String date) async {
    // final d = DateTime.parse(date);
    final doctors = await pb.collections.getOne("doctors");
    final clinics = await pb.collections.getOne("clinics");
    return {
      'name': _dateBookingCollectionFormat(date),
      'type': 'base',
      'schema': [
        {
          'name': 'user_name',
          'type': 'text',
          'required': true,
          'options': {},
        },
        {
          'name': 'user_phone',
          'type': 'text',
          'required': true,
          'options': {
            'min': 11,
          },
        },
        {
          'name': 'user_email',
          'type': 'text',
          'required': false,
          'options': {},
        },
        {
          'name': 'date_time',
          'type': 'text',
          'required': true,
          'options': {},
        },
        {
          'name': 'doc_id',
          'type': 'relation',
          'required': true,
          'options': {
            'collectionId': doctors.id,
            "maxSelect": 1,
          },
        },
        {
          'name': 'clinic_id',
          'type': 'relation',
          'required': true,
          'options': {
            'collectionId': clinics.id,
            "maxSelect": 1,
          },
        },
        {
          'name': 'attended',
          'type': 'bool',
          'required': false,
          'options': {},
        },
        {
          'name': 'type',
          'type': 'select',
          'required': false,
          'options': {
            "maxSelect": 1,
            "values": [
              "Consultation",
              "Followup",
            ],
          }
        },
        {
          'name': 'year',
          'type': 'number',
          'required': true,
          'options': {"noDecimal": true},
        },
        {
          'name': 'month',
          'type': 'number',
          'required': true,
          'options': {
            "noDecimal": true,
            "min": 1,
            "max": 12,
          },
        },
        {
          'name': 'day',
          'type': 'number',
          'required': true,
          'options': {
            "noDecimal": true,
            "min": 1,
            "max": 31,
          },
        },
      ],
      "listRule": "",
      "viewRule": "",
      "createRule": "",
      "updateRule": "",
      "deleteRule": null,
    };
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
      return bookingData;
    } catch (e) {
      if (kDebugMode) {
        print("First Request Exception : ${e.toString()}");
      }
      try {
        //TODO: replace in production
        final admin = await pb.admins
            .authWithPassword("collection@admin.com", "admin.collection");
        // final admin = await pb.admins.authWithPassword(
        //   _adminUserCredentials.userName,
        //   _adminUserCredentials.password,
        // );
        final adminToken = admin.token;

        final collectionSchema = await _bookingCollectionSchema(data.date_time);

        await pb.collections.create(
          headers: {
            "Authorization": "Bearer $adminToken",
            "Content-Type": "application/json"
          },
          body: collectionSchema,
        );

        final bookingResult = await pb
            .collection(_dateBookingCollectionFormat(data.date_time))
            .create(body: data.toPocketbaseJson());

        final bookingData = BookingData.fromPocketbaseJson(
          bookingResult.toJson(),
          data.model,
        );

        return bookingData;
      } catch (e) {
        if (kDebugMode) {
          print("Second Request Exception : ${e.toString()}");
        }
        return null;
      }
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
    return ServerResponseModel(
      doctor: doctor,
      clinic: clinic,
      reviews: reviews,
      total: 1,
    );
  }

  static Future<List<ServerResponseModel>> mainQuery(QueryObject query) async {
    //TODO: missing sorting && filter params
    //TODO: filter by price(l300, m300), sort by price(l->h, h->l)
    //TODO: sort by waiting time
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

    late final _WhichLocQuery _whichLocQuery;

    doctorsData.items.map((d) {
      Clinic? clinic;
      final doctor = Doctor.fromJson(d.toJson());
      // print(d.e)
      final clinicList = (d.expand["clinic_rel"] as List<RecordModel>)
          .map((e) => Clinic.fromJson(e.toJson()))
          .toList();
      //#filtering by area && gov
      if (query.city.isEmpty && query.gov.isEmpty) {
        _whichLocQuery = _WhichLocQuery.noLocation;

        dprint("city & gov => empty");

        clinic = clinicList.first;
      } else if (query.gov.isNotEmpty && query.city.isEmpty) {
        _whichLocQuery = _WhichLocQuery.govOnly;

        dprint("gov => not Empty, city => empty");

        clinic = clinicList.firstWhere((cl) => cl.matchGov(query.gov));
      } else if (query.gov.isNotEmpty && query.city.isNotEmpty) {
        _whichLocQuery = _WhichLocQuery.fullLocation;

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
        //TODO: find which query was performed(noLocation, fullLocation, govOnly )
        switch (query.availability) {
          case "today":
            try {
              switch (_whichLocQuery) {
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
              switch (_whichLocQuery) {
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

    return models;
  }
}

enum _WhichLocQuery {
  noLocation,
  fullLocation,
  govOnly;
}
