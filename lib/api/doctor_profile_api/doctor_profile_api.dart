import 'package:patient/api/pocketbase/pocketbase_helper.dart';
import 'package:patient/models/clinic/clinic.dart';
import 'package:patient/models/doctor/doctor.dart';
import 'package:patient/models/doctor/doctor_website_info.dart';
import 'package:patient/models/search_response_model/search_response_model.dart';
import 'package:pocketbase/pocketbase.dart';

class DoctorProfileApi {
  const DoctorProfileApi({
    required this.doc_id,
  });

  final String doc_id;

  static const String doctorsCollection = 'doctors';

  static const String clinicsCollection = 'clinics';

  // static const String _expand =
  //     'doc_id, doc_id.degree_id, doc_id.speciality_id, speciality_id, city_id, governorate_id, attendance_type_id, venue_id, doctor_website_info_via_doc_id, clinic_waiting_time_via_clinic_id';

  static const String _doctorExpand =
      'degree_id, speciality_id, doctor_website_info_via_doc_id';

  static const String _clinicExpand =
      'city_id, governorate_id, attendance_type_id, venue_id, clinic_waiting_time_via_clinic_id';

  Future<SearchResponseModel> fetch() async {
    final _fetchDoctorResponse =
        await PocketbaseHelper.pb.collection(doctorsCollection).getOne(
              doc_id,
              expand: _doctorExpand,
            );

    final _fetchClinicResponse = await PocketbaseHelper.pb
        .collection(clinicsCollection)
        .getFirstListItem(
          "doc_id = '$doc_id'",
          expand: _clinicExpand,
        );

    final _model = SearchResponseModel(
      doctor: Doctor.fromJson({
        ..._fetchDoctorResponse.toJson(),
        'degree':
            _fetchDoctorResponse.get<RecordModel>('expand.degree_id').toJson(),
        'speciality': _fetchDoctorResponse
            .get<RecordModel>('expand.speciality_id')
            .toJson()
      }),
      clinic: Clinic.fromJson({
        ..._fetchClinicResponse.toJson(),
        'governorate': _fetchClinicResponse
            .get<RecordModel>('expand.governorate_id')
            .toJson(),
        'city':
            _fetchClinicResponse.get<RecordModel>('expand.city_id').toJson(),
        'speciality': _fetchClinicResponse
            .get<RecordModel>('expand.speciality_id')
            .toJson(),
        'venue':
            _fetchClinicResponse.get<RecordModel?>('expand.venue_id')?.toJson(),
        'attendance_type': _fetchClinicResponse
            .get<RecordModel>('expand.attendance_type_id')
            .toJson(),
      }),
      total_count: 1,
      total_pages: 1,
      clinic_waiting_time: _fetchClinicResponse
          .get<RecordModel>('expand.clinic_waiting_time')
          .getIntValue('waiting_time'),
      doctor_website_info: DoctorWebsiteInfo.fromJson({
        ..._fetchDoctorResponse
            .get<RecordModel>('expand.doctor_website_info')
            .toJson(),
      }),
    );

    return _model;
  }

  Future<void> updateDoctorProfileViews(
      String id, Map<String, dynamic> update) async {
    await PocketbaseHelper.pb.collection('doctor_website_info').update(
          id,
          body: update,
        );
  }
}
