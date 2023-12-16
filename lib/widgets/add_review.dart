import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';

class AddReview extends StatelessWidget {
  final String restaurantId;
  final RestaurantDetailProvider provider;

  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  AddReview({super.key, required this.restaurantId, required this.provider});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      insetPadding: const EdgeInsets.all(16),
      title: const Text(
        'Tambah Review',
        style: TextStyle(color: Colors.white),
      ),
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                    isDense: true,
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return "Nama Tidak Boleh Kosong";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _reviewController,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  maxLines: 4,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      labelText: 'Review',
                      border: OutlineInputBorder(),
                      isDense: true,
                      labelStyle: TextStyle(
                        color: Colors.white,
                      )),
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'Review Tidak Boleh Kosong';
                    }
                    return null;
                  },
                )
              ],
            ),
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.all(16),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Batal"),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: accentColor),
            onPressed: () {
              FormState? form = _formKey.currentState;
              if (form != null) {
                if (form.validate()) {
                  provider
                      .postReview(
                          id: restaurantId,
                          name: _nameController.text,
                          review: _reviewController.text)
                      .then((value) {
                    provider.fetchRestaurantDetail(restaurantId);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Sukses menambahkan review'),
                      ),
                    );
                    Navigator.pop(context);
                  });
                }
              }
            },
            child: const Text(
              "Tambah",
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}
