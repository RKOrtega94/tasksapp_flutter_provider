import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tasksapp/shared/layouts/main_layout.dart';

enum AuthLayoutType { login, register }

/// Auth layout
class AuthLayout extends StatelessWidget {
  final String title;
  final Widget child;
  final AuthLayoutType? type;

  const AuthLayout({
    super.key,
    required this.title,
    required this.child,
    this.type,
  });

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
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: MediaQuery.sizeOf(context).width > 600
                ? 400
                : MediaQuery.sizeOf(context).width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.headlineMedium),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 10,
                    children: [child, ..._buildFooter(context)],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFooter(BuildContext context) {
    if (type == AuthLayoutType.login) {
      return [
        RichText(
          text: TextSpan(
            text: 'Don\'t have an account? ',
            children: [
              TextSpan(
                text: 'Register',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).pushNamed('/register');
                  },
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ];
    } else if (type == AuthLayoutType.register) {
      return [const Placeholder()];
    }
    return [const SizedBox.shrink()];
  }
}
