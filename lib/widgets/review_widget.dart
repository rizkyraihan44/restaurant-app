// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:restaurant_app/data/model/restaurant_detail_model.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/widgets/add_review.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({
    Key? key,
    required this.restaurant,
    required this.provider,
  }) : super(key: key);
  final RestaurantDetail restaurant;
  final RestaurantDetailProvider provider;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: restaurant.customerReviews.length * 130,
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return AddReview(
                          restaurantId: restaurant.id, provider: provider);
                    },
                  );
                },
                child: const Text(
                  'Tambah Review',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                  ),
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: restaurant.customerReviews.map((review) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 24,
                              backgroundImage: NetworkImage(
                                'https://i.pravatar.cc/400?u=${review.name}',
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 250,
                                child: Text(
                                  review.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                              Text(
                                review.date,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: Colors.grey[700]),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              SizedBox(
                                width: 250,
                                child: Text(
                                  review.review,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Colors.grey,
                                      ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              )
                            ],
                          )
                        ]),
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(
                      height: 1,
                      thickness: 0.5,
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
