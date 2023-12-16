import 'dart:convert';

import 'package:restaurant_app/data/model/restaurant_detail_model.dart';
import 'package:restaurant_app/data/model/restaurant_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/review_restaurant_model.dart';
import 'package:restaurant_app/data/model/search_restaurant_model.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantList> getRestaurantList() async {
    final response = await http.get(Uri.parse('$_baseUrl/list'));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestaurantDetailResult> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/detail/$id'));
    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<SearchRestaurant> getSearchRestaurant(String query) async {
    final response = await http.get(Uri.parse('$_baseUrl/search?q=$query'));
    if (response.statusCode == 200) {
      return SearchRestaurant.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<ReviewRestaurant> reviewRestaurant({
    required String id,
    required String name,
    required String review,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/review'),
      body: jsonEncode(<String, String>{
        'id': id,
        'name': name,
        'review': review,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return ReviewRestaurant.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
