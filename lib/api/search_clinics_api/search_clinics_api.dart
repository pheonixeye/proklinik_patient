import 'package:patient/api/pocketbase/pocketbase_helper.dart';
import 'package:patient/functions/pretty_print.dart';
import 'package:patient/models/query_model/query.dart';
import 'package:patient/models/search_response_model/search_response_model.dart';
import 'package:pocketbase/pocketbase.dart';

class HxSearchClinics {
  const HxSearchClinics(this.query);

  final Query query;

  static const String collection = 'clinics';

  static const String _expand =
      'doc_id, doc_id.degree_id, doc_id.speciality_id, speciality_id, city_id, governorate_id, attendance_type_id, venue_id, doc_id.doctor_website_info_via_doc_id, clinic_waiting_time_via_clinic_id';

  static const String _publishFilter = "&& published = true";

  static const _perPage = 5;

  Future<List<SearchResponseModel>?> search() async {
    final _response = await PocketbaseHelper.pb.collection(collection).getList(
          page: query.pageNumber,
          perPage: _perPage,
          filter: "${query.baseQueryFilter} $_publishFilter",
          expand: _expand,
          sort: '-created',
        );

    // prettyPrint(_response);

    final _searchResults = _response.items.map((item) {
      prettyPrint(
          item.get<RecordModel>('expand.doc_id.expand.speciality_id').toJson());
      return SearchResponseModel.fromJson({
        'clinic_waiting_time': item.get<List<dynamic>>(
            'expand.clinic_waiting_time_via_clinic_id')[0]['waiting_time'],
        'doctor_website_info': item.get<List<dynamic>>(
            'expand.doc_id.expand.doctor_website_info_via_doc_id')[0],
        'total_count': _response.totalItems,
        'total_pages': _response.totalPages,
        'doctor': {
          ...item.get<RecordModel>('expand.doc_id').toJson(),
          'degree':
              item.get<RecordModel>('expand.doc_id.expand.degree_id').toJson(),
          'speciality': item
              .get<RecordModel>('expand.doc_id.expand.speciality_id')
              .toJson(),
        },
        'clinic': {
          ...item.toJson(),
          'governorate':
              item.get<RecordModel>('expand.governorate_id').toJson(),
          'city': item.get<RecordModel>('expand.city_id').toJson(),
          'speciality': item.get<RecordModel>('expand.speciality_id').toJson(),
          'venue': item.get<RecordModel?>('expand.venue_id')?.toJson(),
          'attendance_type':
              item.get<RecordModel>('expand.attendance_type_id').toJson(),
        },
      });
    }).toList();

    return _searchResults;
  }
}
