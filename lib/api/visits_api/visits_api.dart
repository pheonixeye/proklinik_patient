import 'package:patient/api/pocketbase/pocketbase_helper.dart';
import 'package:patient/models/visit/visit.dart';
import 'package:patient/models/visit/visit_response_model.dart';
import 'package:pocketbase/pocketbase.dart';

class VisitsApi {
  const VisitsApi();

  static const String collection = 'visits';

  static const String _expand =
      'doc_id, clinic_id, visit_type_id, visit_status_id';

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

    return Visit.fromJson({
      ..._response.toJson(),
      'doctor': _response.get<RecordModel>('expand.doc_id').toJson(),
      'clinic': _response.get<RecordModel>('expand.clinic_id').toJson(),
      'visit_type': _response.get<RecordModel>('expand.visit_type_id').toJson(),
      'visit_status':
          _response.get<RecordModel>('expand.visit_status_id').toJson(),
    });
  }

  Future<void> updateVisit(String visit_id, Map<String, dynamic> update) async {
    await PocketbaseHelper.pb
        .collection(collection)
        .update(visit_id, body: update);
  }
}
