import 'package:json_annotation/json_annotation.dart';

import 'package:tasksapp/features/auth/domain/entity/user.dart';

part 'user_model.g.dart';

/// UserModel class
/// UserModel is a model class that extends User
@JsonSerializable()
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    super.displayName,
    super.photoUrl,
  });

  /// [UserModel].fromJson factory constructor
  /// [UserModel].fromJson is a factory constructor that takes a [Map] as a parameter and returns a [UserModel] object
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// [UserModel].toJson is a method that returns a [Map] object
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
