import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/enum/result_state.dart';
import 'package:restaurant_app/provider/search_restaurant_provider.dart';
import 'package:restaurant_app/widgets/card.dart';
import 'package:restaurant_app/widgets/message_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});
  static const String routeName = '/search_page';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchRestaurantProvider(
        apiService: ApiService(),
      ),
      builder: (context, _) {
        return Scaffold(
          backgroundColor: primaryColor,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: primaryColor,
            elevation: 0,
            title: const Text(
              "Search",
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.search,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    border: InputBorder.none,
                    hintText: 'Search by name',
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ),
                  onChanged: (query) {
                    Provider.of<SearchRestaurantProvider>(context,
                            listen: false)
                        .fetchSearchRestaurant(query);
                  },
                ),
              ),
              Consumer<SearchRestaurantProvider>(
                builder: (_, provider, __) {
                  if (provider.state == ResultState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (provider.state == ResultState.hasData) {
                    return Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          itemCount: provider.result.restaurants.length,
                          itemBuilder: (_, index) {
                            final restaurant =
                                provider.result.restaurants[index];
                            return ListCard(restaurant: restaurant);
                          }),
                    );
                  } else if (provider.state == ResultState.noData) {
                    return const TextMessage(
                      message:
                          'Data Tidak Ditemukan, silahkan ketik di pencarian',
                    );
                  } else if (provider.state == ResultState.error) {
                    return TextMessage(
                        message: 'Error ==> Tidak ada internet',
                        onPressed: () {
                          provider.fetchSearchRestaurant(provider.message);
                        });
                  } else {
                    return const SizedBox();
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }
}
