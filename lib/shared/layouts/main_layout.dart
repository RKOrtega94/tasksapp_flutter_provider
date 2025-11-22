import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(extendBody: true, body: SafeArea(child: child));
  }
}
