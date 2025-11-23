import 'package:tasksapp/features/auth/domain/entity/user.dart';

abstract class IAuthRepository {
  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<User> signIn({required String email, required String password});

  Future<void> signOut();

  User? get currentUser;

  Stream<User?> get authStateChanges;
}
