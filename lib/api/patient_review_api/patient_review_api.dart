import 'package:flutter/foundation.dart' show debugPrint;
import 'package:proklinik_patient/api/notifications_api/notifications_api.dart';
import 'package:proklinik_patient/api/pocketbase/pocketbase_helper.dart';
import 'package:proklinik_patient/models/review/review_response_model.dart';
import 'package:proklinik_patient/models/server_notification/server_notification.dart';
import 'package:proklinik_patient/models/visit/visit_response_model.dart';
import 'package:pocketbase/pocketbase.dart';

class PatientReviewApi {
  const PatientReviewApi();

  static const String collection = 'reviews';

  static const String visitsCollection = 'visits';

  // static const String _expand = 'review_status_id';

  Future<VisitResponseModel?> fetchVisit(String visit_id) async {
    try {
      final _response = await PocketbaseHelper.pb
          .collection(visitsCollection)
          .getOne(visit_id);
      return VisitResponseModel.fromJson({
        ..._response.toJson(),
      });
    } on ClientException catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<ReviewResponseModel?> fetchReview(String visit_id) async {
    try {
      final _response =
          await PocketbaseHelper.pb.collection(collection).getFirstListItem(
                "visit_id = '$visit_id'",
              );

      final _review = ReviewResponseModel.fromJson({
        ..._response.toJson(),
      });

      return _review;
    } on ClientException catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> submitReview(ReviewResponseModel model) async {
    final _result = await PocketbaseHelper.pb.collection(collection).create(
          body: model.toJson(),
        );
    final _notification = ServerNotification(
      type: NotificationType.new_review,
      id: _result.id,
    );

    await NotificationsApi(_notification).notify();
  }
}
