import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/enum/result_state.dart';
import 'package:restaurant_app/data/model/restaurant_detail_model.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String restaurantId;

  RestaurantDetailProvider({
    required this.apiService,
    required this.restaurantId,
  }) {
    fetchRestaurantDetail(restaurantId);
  }

  late RestaurantDetailResult _restaurantDetailResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  RestaurantDetailResult get result => _restaurantDetailResult;
  ResultState get state => _state;

  Future<dynamic> fetchRestaurantDetail(String restaurantId) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurantDetail =
          await apiService.getRestaurantDetail(restaurantId);

      _restaurantDetailResult = restaurantDetail;
      _state = ResultState.hasData;
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error --> $e';
      notifyListeners();
    }
  }

  Future<dynamic> postReview({
    required String id,
    required String name,
    required String review,
  }) async {
    try {
      final postReviewResult = await apiService.reviewRestaurant(
        id: id,
        name: name,
        review: review,
      );
      if (!postReviewResult.error && postReviewResult.message == 'success') {
        await fetchRestaurantDetail(id);

        return ResultState.success;
      }
      return ResultState.error;
    } catch (e) {
      _message = 'Error --> $e';
      notifyListeners();
      return ResultState.error;
    }
  }
}
