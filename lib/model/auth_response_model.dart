import 'dart:convert';
import 'package:my_project/model/user_model.dart';

AuthResponseModel authResponseModelFromJson(String str) =>
    AuthResponseModel.fromJson(json.decode(str));

String authResponseModelToJson(AuthResponseModel data) =>
    json.encode(data.toJson());

class AuthResponseModel {
  AuthResponseModel({
    required this.token,
    required this.user,
  });

  String token;
  UserModel user;

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    final userJson = json["user"] ?? {};
    return AuthResponseModel(
      token: json["token"] ?? '',
      user: UserModel.fromJson(userJson),
    );
  }

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
      };
}
