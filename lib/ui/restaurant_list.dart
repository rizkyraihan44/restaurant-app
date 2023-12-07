import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/widgets/card.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  color: secondaryColor,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 24, top: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Restaurant',
                          style: TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Recomendation Restaurant For You',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                    color: primaryColor,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: _buildList(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder<String> _buildList(BuildContext context) {
    return FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/restaurant_data.json'),
        builder: (context, snapshot) {
          final restaurantsData = restaurantsFromJson(snapshot.data ?? '');
          int index = 0;
          return Column(
              children: restaurantsData.restaurants.map((e) {
            return Container(
              margin: EdgeInsets.only(
                top: index == 1 ? 0 : 30,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, DetailPage.routeName,
                      arguments: e);
                },
                child: ListCard(
                  city: e.city,
                  img: e.pictureId,
                  name: e.name,
                  rating: e.rating.toString(),
                  desc: e.description,
                ),
              ),
            );
          }).toList());
        });
  }
}
