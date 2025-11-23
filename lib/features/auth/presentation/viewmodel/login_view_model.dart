import 'package:flutter/material.dart';
import 'package:tasksapp/features/auth/presentation/viewmodel/auth_view_model.dart';

class LoginViewModel extends AuthViewModel {
  String email = '';
  String password = '';

  LoginViewModel({required super.authRepository});

  Future<void> login() async {
    setAuthState(AuthStatus.loading);
    setError(null);
    try {
      await repository.signIn(email: email, password: password);
      setAuthState(AuthStatus.authenticated);
    } catch (e) {
      final errorMessage = e.toString();
      setError(errorMessage);
      showMessage(errorMessage);
      setAuthState(AuthStatus.unauthenticated);
    }
  }
}
