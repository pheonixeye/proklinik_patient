import 'package:patient/api/pocketbase/pocketbase_helper.dart';
import 'package:patient/functions/pretty_print.dart';
import 'package:patient/models/clinic/clinic.dart';
import 'package:patient/models/doctor/doctor.dart';
import 'package:patient/models/visit/visit.dart';
import 'package:patient/models/visit/visit_response_model.dart';
import 'package:pocketbase/pocketbase.dart';

class VisitsApi {
  const VisitsApi();

  static const String collection = 'visits';

  static const String _expand =
      'doc_id, doc_id.degree_id, doc_id.speciality_id, clinic_id, clinic_id.city_id, clinic_id.governorate_id, clinic_id.attendance_type_id, clinic_id.venue_id, clinic_id.speciality_id, visit_type_id, visit_status_id';

  Future<void> createVisit(VisitResponseModel model) async {
    await PocketbaseHelper.pb.collection(collection).create(
          body: model.toJson(),
        );
  }

  Future<Visit?> fetchVisitById(String visit_id) async {
    final _response = await PocketbaseHelper.pb.collection(collection).getOne(
          visit_id,
          expand: _expand,
        );

    prettyPrint(_response);

    final _visit = Visit.fromJson({
      ..._response.toJson(),
      'doctor': Doctor.fromJson({
        ..._response.get<RecordModel>('expand.doc_id').toJson(),
        'degree': _response
            .get<RecordModel>('expand.doc_id.expand.degree_id')
            .toJson(),
        'speciality': _response
            .get<RecordModel>('expand.doc_id.expand.speciality_id')
            .toJson()
      }).toJson(),
      'clinic': Clinic.fromJson({
        ..._response.get<RecordModel>('expand.clinic_id').toJson(),
        'governorate': _response
            .get<RecordModel>('expand.clinic_id.expand.governorate_id')
            .toJson(),
        'city': _response
            .get<RecordModel>('expand.clinic_id.expand.city_id')
            .toJson(),
        'speciality': _response
            .get<RecordModel>('expand.clinic_id.expand.speciality_id')
            .toJson(),
        'venue': _response
            .get<RecordModel?>('expand.clinic_id.expand.venue_id')
            ?.toJson(),
        'attendance_type': _response
            .get<RecordModel>('expand.clinic_id.expand.attendance_type_id')
            .toJson(),
      }).toJson(),
      'visit_type':
          _response.get<RecordModel?>('expand.visit_type_id')?.toJson(),
      'visit_status':
          _response.get<RecordModel>('expand.visit_status_id').toJson(),
      'visit_shift': {
        ..._response.toJson()['visit_shift'] as Map<String, dynamic>
      },
    });

    return _visit;
  }

  Future<void> updateVisit(String visit_id, Map<String, dynamic> update) async {
    await PocketbaseHelper.pb
        .collection(collection)
        .update(visit_id, body: update);
  }
}
