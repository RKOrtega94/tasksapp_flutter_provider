import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tasksapp/features/auth/domain/entity/user.dart';
import 'package:tasksapp/features/auth/domain/repository/auth_repository.dart';
import 'package:tasksapp/shared/dialogs/show_snackbar.dart';

enum AuthStatus { initial, authenticated, unauthenticated, loading }

class AuthViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  // Providers
  final IAuthRepository repository;

  // Auth state
  StreamSubscription<User?>? _authStateSubscription;

  AuthStatus _status = AuthStatus.initial;
  User? _user;
  String? _error;

  // Getters
  AuthStatus get status => _status;
  User? get user => _user;
  String? get error => _error;
  bool get isLoading => _status == AuthStatus.loading;
  bool get isAuthenticated => _user != null;

  // Message stream for one-off events (e.g. Snackbars)
  final _messageController = StreamController<String>.broadcast();
  Stream<String> get messageStream => _messageController.stream;

  AuthViewModel({required IAuthRepository authRepository})
    : repository = authRepository {
    _initialize();
  }

  @override
  void dispose() {
    _messageController.close();
    _authStateSubscription?.cancel();
    super.dispose();
  }

  void _initialize() {
    setAuthState(AuthStatus.loading);
    _user = repository.currentUser;
    if (_user != null) {
      setAuthState(AuthStatus.authenticated);
    } else {
      setAuthState(AuthStatus.unauthenticated);
    }

    _authStateSubscription = repository.authStateChanges.listen((user) {
      _user = user;
      if (user != null) {
        setAuthState(AuthStatus.authenticated);
      } else {
        setAuthState(AuthStatus.unauthenticated);
      }
    });
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    setAuthState(AuthStatus.loading);
    setError(null);
    try {
      await repository.signUp(name: name, email: email, password: password);
      setAuthState(AuthStatus.authenticated);
    } catch (e) {
      final errorMessage = e.toString();
      setError(errorMessage);
      showMessage(errorMessage);
      setAuthState(AuthStatus.unauthenticated);
    }
  }

  void setAuthState(AuthStatus status) {
    _status = status;
    notifyListeners();
  }

  void setError(String? error) {
    _error = error;
    notifyListeners();
  }

  void showMessage(String message) {
    showSnackbar(formKey.currentContext!, message, type: SnackbarType.error);
  }
}
