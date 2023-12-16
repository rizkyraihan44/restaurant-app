// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant_detail_model.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';

class DetailRestaurant extends StatelessWidget {
  const DetailRestaurant({
    Key? key,
    required this.restaurant,
    required this.provider,
  }) : super(key: key);

  final RestaurantDetail restaurant;
  final RestaurantDetailProvider provider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(restaurant.name,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: Colors.white)),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.orange,
                    size: 28,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    '${restaurant.rating}',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            restaurant.city,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white),
          ),
          const Divider(),
          const SizedBox(
            height: 8,
          ),
          const Text(
            'Description',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          Text(
            restaurant.description,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const Divider(),
          const SizedBox(
            height: 16,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Menu Makanan',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: restaurant.menus.foods.length,
              itemBuilder: (context, index) {
                return Card(
                  color: accentColor,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Center(
                      child: Text(
                        restaurant.menus.foods[index].name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Menu Minuman',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: restaurant.menus.drinks.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: accentColor,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Center(
                        child: Text(
                          restaurant.menus.drinks[index].name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }
}
