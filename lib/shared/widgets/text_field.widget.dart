import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Custom TextField Widget
class AppTextField<T> extends StatelessWidget {
  final String Function(T) selector;
  final String? Function(T) errorSelector;
  final void Function(T, String) onChange;

  const AppTextField({
    super.key,
    required this.selector,
    required this.errorSelector,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<T, ({String value, String? error})>(
      builder: (context, data, child) {
        return TextField(decoration: InputDecoration(labelText: 'test'));
      },
      selector: (_, value) {
        return (value: selector(value), error: errorSelector(value));
      },
    );
  }
}
