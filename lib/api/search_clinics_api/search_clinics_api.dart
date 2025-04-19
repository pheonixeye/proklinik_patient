import 'package:patient/api/pocketbase/pocketbase_helper.dart';
import 'package:patient/models/query_model/query.dart';
import 'package:patient/models/search_response_model/search_response_model.dart';
import 'package:pocketbase/pocketbase.dart';

class HxSearchClinics {
  const HxSearchClinics(this.query);

  final Query query;

  static const String collection = 'clinics';

  static const String _expand =
      'doc_id, doc_id.degree_id, doc_id.speciality_id, speciality_id, city_id, governorate_id, attendance_type_id, venue_id';

  Future<List<SearchResponseModel>?> search() async {
    final _response = await PocketbaseHelper.pb.collection(collection).getList(
          page: query.pageNumber,
          filter: "${query.baseQueryFilter} && published = 'true'",
          expand: _expand,
          sort: '-created',
        );

    Map<String, dynamic> _clinic_waiting_times_map = {};
    Map<String, dynamic> _doctor_rating_views_map = {};

    _response.items.map((item) async {
      final _clinic_waiting_time = await PocketbaseHelper.pb
          .collection('clinic_waiting_time')
          .getFirstListItem("clinic_id = '${item.id}'");
      _clinic_waiting_times_map[item.id] =
          _clinic_waiting_time.get<int?>('waiting_time') ?? 0;
      final _doctor_views_rating = await PocketbaseHelper.pb
          .collection('doctor_views_rating')
          .getFirstListItem(
              "doc_id = '${item.get<RecordModel>('expand.doc_id').id}'");
      _doctor_rating_views_map[item.id] = {
        'views': _doctor_views_rating.get<int?>('views') ?? 0,
        'rating': _doctor_views_rating.get<int?>('rating') ?? 0
      };
    }).toList();

    final _searchResults = _response.items.map((item) {
      return SearchResponseModel.fromJson({
        'clinic_waiting_time': _clinic_waiting_times_map[item.id],
        'doctor_views':
            _doctor_rating_views_map[item.get<RecordModel>('expand.doc_id').id]
                ['views'],
        'doctor_rating':
            _doctor_rating_views_map[item.get<RecordModel>('expand.doc_id').id]
                ['rating'],
        'total_count': _response.totalItems,
        'total_pages': _response.totalPages,
        'doctor': {
          ...item.get<RecordModel>('expand.doc_id').toJson(),
          'degree': item.get<RecordModel>('expand.doc_id.degree_id').toJson(),
          'speciality':
              item.get<RecordModel>('expand.doc_id.speciality_id').toJson(),
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
