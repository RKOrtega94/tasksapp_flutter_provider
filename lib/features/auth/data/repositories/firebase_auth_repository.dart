import 'package:tasksapp/core/errors/auth_exception.dart';
import 'package:tasksapp/features/auth/data/mapper/user_mapper.dart';
import 'package:tasksapp/features/auth/data/providers/firebase_auth_provider.dart';
import 'package:tasksapp/features/auth/domain/entity/user.dart';
import 'package:tasksapp/features/auth/domain/repository/auth_repository.dart';

class FirebaseAuthRepository implements IAuthRepository {
  final FirebaseAuthProvider _provider;

  FirebaseAuthRepository({FirebaseAuthProvider? provider})
    : _provider = provider ?? FirebaseAuthProvider();

  /// Sign up with email and password
  ///
  /// Returns the user if the sign up was successful
  /// Throws [AuthException] if an error occurs
  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final firebaseUser = await _provider.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _provider.sendEmailVerification();
      if (firebaseUser == null) {
        throw AuthException('Error al crear el usuario');
      }
      return UserMapper.fromFirebase(firebaseUser);
    } catch (e) {
      rethrow;
    }
  }

  /// Sign in with email and password
  ///
  /// Returns the user if the sign in was successful
  /// Throws [AuthException] if an error occurs
  Future<User> signIn({required String email, required String password}) async {
    try {
      final firebaseUser = await _provider.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (firebaseUser == null) {
        throw AuthException('Error al iniciar sesión');
      }
      return UserMapper.fromFirebase(firebaseUser);
    } catch (e) {
      rethrow;
    }
  }

  /// Sign out
  ///
  /// Throws [AuthException] if an error occurs
  Future<void> signOut() async {
    try {
      await _provider.signOut();
    } catch (e) {
      rethrow;
    }
  }

  /// Get the current user
  ///
  /// Returns the user if the user is signed in
  /// Returns null if the user is not signed in
  User? get currentUser {
    final firebaseUser = _provider.currentUser;
    if (firebaseUser == null) {
      return null;
    }
    return UserMapper.fromFirebase(firebaseUser);
  }

  /// Stream of authentication state changes
  ///
  /// Returns the user if the user is signed in
  /// Returns null if the user is not signed in
  Stream<User?> get authStateChanges {
    return _provider.authStateChanges.map((user) {
      if (user == null) {
        return null;
      }
      return UserMapper.fromFirebase(user);
    });
  }
}
