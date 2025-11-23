import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasksapp/features/auth/data/model/user_model.dart';

class UserMapper {
  static UserModel fromFirebase(User user) {
    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
  }
}
