import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:tasksapp/core/errors/auth_exception.dart';

/// Provider for Firebase Authentication
class FirebaseAuthProvider {
  final auth.FirebaseAuth _auth;

  FirebaseAuthProvider({auth.FirebaseAuth? firebaseAuth})
    : _auth = firebaseAuth ?? auth.FirebaseAuth.instance;

  /// Sign up with email and password
  ///
  /// Returns the user if the sign up was successful
  /// Throws [AuthException] if an error occurs
  Future<auth.User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Sign in with email and password
  ///
  /// Returns the user if the sign in was successful
  /// Throws [AuthException] if an error occurs
  Future<auth.User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Send email verification
  ///
  /// Send verification email to the user
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser!.sendEmailVerification();
    } on auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Verify email
  ///
  /// Send verification email to the user
  Future<void> verifyEmail() async {
    try {
      await _auth.currentUser!.sendEmailVerification();
    } on auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Returns true if the user is verified
  Future<bool> isEmailVerified() async {
    return _auth.currentUser!.emailVerified;
  }

  /// Returns the current user
  auth.User? get currentUser => _auth.currentUser;

  /// Stream of authentication state changes
  Stream<auth.User?> get authStateChanges => _auth.authStateChanges();

  /// Stream of user changes
  Stream<auth.User?> get userChanges => _auth.userChanges();

  /// Manejar excepciones de Firebase Auth
  AuthException _handleAuthException(auth.FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return AuthException('Este email ya está registrado');
      case 'invalid-email':
        return AuthException('Email inválido');
      case 'operation-not-allowed':
        return AuthException('Operación no permitida');
      case 'weak-password':
        return AuthException('La contraseña es muy débil');
      case 'user-disabled':
        return AuthException('Esta cuenta ha sido deshabilitada');
      case 'user-not-found':
        return AuthException('Usuario no encontrado');
      case 'wrong-password':
        return AuthException('Contraseña incorrecta');
      case 'too-many-requests':
        return AuthException('Demasiados intentos. Intenta más tarde');
      case 'network-request-failed':
        return AuthException('Error de conexión. Verifica tu internet');
      case 'requires-recent-login':
        return AuthException(
          'Debes iniciar sesión nuevamente para realizar esta acción',
        );
      case 'credential-already-in-use':
        return AuthException('Esta credencial ya está en uso');
      default:
        return AuthException('Error de autenticación: ${e.message}');
    }
  }
}
