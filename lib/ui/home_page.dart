import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/ui/restaurant_list.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: secondaryColor,
      body: RestaurantListPage(),
    );
  }
}
