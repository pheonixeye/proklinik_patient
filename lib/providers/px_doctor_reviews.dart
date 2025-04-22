import 'package:flutter/material.dart';
import 'package:patient/api/reviews_api/reviews_api.dart';
import 'package:patient/models/review/review.dart';

class PxDocReviews extends ChangeNotifier {
  final ReviewsApi service;

  PxDocReviews({
    required this.service,
  }) {
    _fetchDoctorReviews();
  }

  static const int _perPage = 5;

  List<Review>? _reviews;
  List<Review>? get reviews => _reviews;

  List<Review> _lastFetchResult = [];

  static int _page = 1;
  int get page => _page;

  static bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> _fetchDoctorReviews() async {
    _isLoading = true;
    notifyListeners();
    final _result = await service.fetchDoctorReviews(
      page: page,
      perPage: _perPage,
    );
    _reviews ??= [];
    _lastFetchResult = _result;
    _reviews?.addAll(_result);
    notifyListeners();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMoreReviews() async {
    if (_reviews == null) {
      _page = 1;
      await _fetchDoctorReviews();
      return;
    }
    if (_lastFetchResult.length < 5 && _reviews != null) {
      return;
    }
    _isLoading = true;
    notifyListeners();
    _page++;
    final _result = await service.fetchDoctorReviews(
      page: _page,
      perPage: _perPage,
    );
    _lastFetchResult = _result;
    _reviews?.addAll(_result);
    notifyListeners();
    _isLoading = false;
    notifyListeners();
  }
}
