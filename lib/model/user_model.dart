import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.name,
    this.role,
    this.email,
    this.phone,
  });

  String? name;
  String? role;
  String? email;
  String? phone;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        email: json["email"],
        role: json["role"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "role": role,
        "email": email,
        "phone": phone,
      };
}
