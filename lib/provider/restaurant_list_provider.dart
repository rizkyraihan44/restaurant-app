// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/enum/result_state.dart';
import 'package:restaurant_app/data/model/restaurant_list_model.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({
    required this.apiService,
  }) {
    fetchAllRestaurant();
  }

  late RestaurantList _restaurantList;
  late ResultState _state;
  String _message = '';

  RestaurantList get result => _restaurantList;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurantList = await apiService.getRestaurantList();
      if (restaurantList.count == 0 && restaurantList.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();

        return _message = 'No Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();

        return _restaurantList = restaurantList;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();

      return _message = 'Error --> $e';
    }
  }
}
