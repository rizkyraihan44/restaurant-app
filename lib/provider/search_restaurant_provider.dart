import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/enum/result_state.dart';
import 'package:restaurant_app/data/model/restaurant_list_model.dart';
import 'package:restaurant_app/data/model/search_restaurant_model.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({
    required this.apiService,
  });

  late SearchRestaurant _searchRestaurant;
  ResultState? _state;
  String _message = '';
  final List<Restaurant> _filteredResults = [];

  SearchRestaurant get result => _searchRestaurant;
  ResultState? get state => _state;
  String get message => _message;
  List<Restaurant> get filteredResults => _filteredResults;

  Future<dynamic> fetchSearchRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final searchRestaurant = await apiService.getSearchRestaurant(query);
      if (searchRestaurant.founded == 0 &&
          searchRestaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();

        return _message = 'No Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        searchRestaurant.restaurants
            .where(
                (item) => item.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
        return _searchRestaurant = searchRestaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();

      return _message = 'Error: --> $e.';
    }
  }
}
