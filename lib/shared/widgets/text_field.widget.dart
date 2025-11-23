import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Custom TextField Widget
class AppTextField<T> extends StatefulWidget {
  final String label;
  final String Function(T) selector;
  final void Function(T, String) onChange;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool isPassword;

  const AppTextField({
    super.key,
    required this.label,
    required this.selector,
    required this.onChange,
    this.keyboardType,
    this.validator,
    this.isPassword = false,
  });

  @override
  State<AppTextField<T>> createState() => _AppTextFieldState<T>();
}

class _AppTextFieldState<T> extends State<AppTextField<T>> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (context, vm, child) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: widget.label,
            filled: true,
            fillColor: Theme.of(
              context,
            ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(
                  context,
                ).colorScheme.outline.withValues(alpha: 0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _isObscured ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                  )
                : null,
          ),
          onChanged: (value) => widget.onChange(vm, value),
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          obscureText: _isObscured,
        );
      },
    );
  }
}
