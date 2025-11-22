import 'package:flutter/material.dart';
import 'package:tasksapp/shared/layouts/main_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          elevation: 4,
          color: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Placeholder(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
