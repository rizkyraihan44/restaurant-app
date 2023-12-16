// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';

import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/enum/result_state.dart';
import 'package:restaurant_app/data/model/restaurant_list_model.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/widgets/detail_restaurant.dart';
import 'package:restaurant_app/widgets/message_widget.dart';
import 'package:restaurant_app/widgets/review_widget.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  static String routeName = '/detail_page';
  final Restaurant restaurant;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (context) => RestaurantDetailProvider(
        apiService: ApiService(),
        restaurantId: widget.restaurant.id,
      ),
      child: Scaffold(
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 1.5,
            width: double.infinity,
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.network(
                        'https://restaurant-api.dicoding.dev/images/large/${widget.restaurant.pictureId}'),
                    Container(
                      margin: const EdgeInsets.only(top: 24),
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: secondaryColor,
                                borderRadius: BorderRadius.circular(25)),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                  size: 30,
                                )),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.bookmark_border,
                                size: 30,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
                TabBar(
                  controller: tabController,
                  dividerColor: Colors.transparent,
                  tabs: const [
                    Tab(
                      text: 'ABOUT',
                    ),
                    Tab(
                      text: 'Review',
                    ),
                  ],
                  labelColor: Colors.white,
                  indicatorColor: accentColor,
                  indicatorPadding: const EdgeInsets.all(4),
                ),
                const SizedBox(
                  height: 8,
                ),
                Consumer<RestaurantDetailProvider>(
                    builder: (context, provider, __) {
                  if (provider.state == ResultState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (provider.state == ResultState.hasData) {
                    return Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          Column(
                            children: [
                              DetailRestaurant(
                                restaurant: provider.result.restaurant,
                                provider: provider,
                              ),
                            ],
                          ),
                          ReviewWidget(
                            restaurant: provider.result.restaurant,
                            provider: provider,
                          ),
                        ],
                      ),
                    );
                  } else if (provider.state == ResultState.error) {
                    return TextMessage(
                        message: 'Error ==> Tidak ada internet',
                        onPressed: () {
                          provider.fetchRestaurantDetail(widget.restaurant.id);
                        });
                  } else if (provider.state == ResultState.noData) {
                    return TextMessage(
                        message: provider.message,
                        onPressed: () {
                          provider.fetchRestaurantDetail(widget.restaurant.id);
                        });
                  } else {
                    return const SizedBox();
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
