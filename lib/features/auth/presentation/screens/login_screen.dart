import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasksapp/features/auth/presentation/layout/auth_layout.dart';
import 'package:tasksapp/features/auth/presentation/viewmodel/login_view_model.dart';
import 'package:tasksapp/shared/widgets/text_field.widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(authRepository: context.read()),
      child: AuthLayout(
        title: 'Login',
        type: AuthLayoutType.login,
        child: Consumer<LoginViewModel>(
          builder: (context, viewModel, _) {
            return Form(
              key: viewModel.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 16,
                children: [
                  AppTextField<LoginViewModel>(
                    label: 'Email',
                    selector: (viewModel) => viewModel.email,
                    onChange: (viewModel, value) => viewModel.email = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      // Simple email regex
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  AppTextField<LoginViewModel>(
                    label: 'Password',
                    selector: (viewModel) => viewModel.password,
                    onChange: (viewModel, value) => viewModel.password = value,
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  if (viewModel.isLoading)
                    const CircularProgressIndicator()
                  else
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (viewModel.formKey.currentState!.validate()) {
                            viewModel.login();
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
