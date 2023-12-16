// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:restaurant_app/data/model/restaurant_list_model.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/widgets/favorite_button.dart';

class ListCard extends StatelessWidget {
  const ListCard({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName,
            arguments: restaurant);
      },
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.symmetric(vertical: 4),
          height: 150,
          child: Card(
            color: Colors.white,
            child: Stack(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      child: Image.network(
                        'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                        fit: BoxFit.cover,
                        height: 150,
                        width: 150,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            restaurant.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.location_on),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                restaurant.city,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.orange,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                "${restaurant.rating}",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            restaurant.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const Positioned(
                  left: 5,
                  top: 5,
                  child: FavButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
