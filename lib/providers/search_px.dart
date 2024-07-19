import 'package:flutter/foundation.dart';
import 'package:patient/core/pocketbase/pocketbase_helper.dart';
import 'package:proklinik_models/models/query_object.dart';
import 'package:proklinik_models/models/server_response_model.dart';

class PxSearchController extends ChangeNotifier {
  final QueryObject query;

  PxSearchController({
    required this.query,
  }) {
    init();
  }

  List<ServerResponseModel>? _responseModel;
  List<ServerResponseModel>? get responseModel => _responseModel;

  Future<void> init() async {
    //todo: perform base search query
    if (kDebugMode) {
      print("PxSearchController().init($query)");
    }

    _responseModel = await PocketbaseHelper.mainQuery(query);
    notifyListeners();
  }
}
