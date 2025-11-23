import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:tasksapp/features/auth/data/providers/firebase_auth_provider.dart';
import 'package:tasksapp/features/auth/data/repositories/firebase_auth_repository.dart';
import 'package:tasksapp/features/auth/domain/repository/auth_repository.dart';

final List<SingleChildWidget> authProviders = [
  Provider<FirebaseAuthProvider>(create: (_) => FirebaseAuthProvider()),
  ProxyProvider<FirebaseAuthProvider, IAuthRepository>(
    update: (_, authProvider, _) =>
        FirebaseAuthRepository(provider: authProvider),
  ),
];
