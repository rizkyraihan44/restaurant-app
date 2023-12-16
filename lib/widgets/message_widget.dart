import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';

class TextMessage extends StatelessWidget {
  final String message;
  final Function()? onPressed;

  const TextMessage({
    super.key,
    required this.message,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            message,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 8),
          if (onPressed != null)
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: accentColor),
              onPressed: onPressed,
              child: const Text(
                'Refresh',
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
