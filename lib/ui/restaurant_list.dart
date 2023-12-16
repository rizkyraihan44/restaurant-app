// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/enum/result_state.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/widgets/card.dart';
import 'package:restaurant_app/widgets/message_widget.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantListProvider>(
      create: (context) => RestaurantListProvider(apiService: ApiService()),
      child: Scaffold(
        backgroundColor: secondaryColor,
        body: Consumer<RestaurantListProvider>(builder: (context, provider, _) {
          if (provider.state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.state == ResultState.hasData) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          color: secondaryColor,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 24, top: 8, right: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Restaurant',
                                      style: TextStyle(
                                          fontSize: 32,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.search,
                                        size: 35,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, SearchPage.routeName);
                                      },
                                    )
                                  ],
                                ),
                                const Text(
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
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: provider.result.restaurants.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin:
                                      EdgeInsets.only(top: index == 0 ? 32 : 8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: ListCard(
                                      restaurant:
                                          provider.result.restaurants[index]),
                                );
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else if (provider.state == ResultState.noData) {
            return TextMessage(
                message: provider.message,
                onPressed: () {
                  provider.fetchAllRestaurant();
                });
          } else if (provider.state == ResultState.error) {
            return TextMessage(
              message: 'Error --> Tidak ada Internet',
              onPressed: () {
                provider.fetchAllRestaurant();
              },
            );
          } else {
            return const SizedBox();
          }
        }),
      ),
    );
  }
}
