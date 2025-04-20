import 'package:patient/api/pocketbase/pocketbase_helper.dart';
import 'package:patient/models/review/review.dart';
import 'package:pocketbase/pocketbase.dart';

class ReviewsApi {
  const ReviewsApi({required this.doc_id});

  final String doc_id;

  static const String collection = 'reviews';

  static const String _sort = '-created';

  static const String _expand = 'review_status_id';

  Future<List<Review>> fetchDoctorReviews({
    required int page,
    int perPage = 5,
  }) async {
    final _response = await PocketbaseHelper.pb.collection(collection).getList(
          page: page,
          perPage: perPage,
          filter: "doc_id = '$doc_id'",
          sort: _sort,
          expand: _expand,
        );

    return _response.items.map((item) {
      return Review.fromJson({
        ...item.toJson(),
        'review_status':
            item.get<RecordModel>('expand.review_status_id').toJson(),
      });
    }).toList();
  }
}
