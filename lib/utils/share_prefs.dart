import 'dart:convert';
import 'dart:developer';

import 'package:my_project/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String tokenKey = 'tokenkey';
  static const String userIdKey = 'userId';
  static const String userKey = 'user';
  static const String bookStatsKey = 'bookStats';

  SharedPreferences? _prefs;

  Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //Token
  String? get token => _prefs!.getString(tokenKey);

  set token(String? token) {
    _prefs?.setString(tokenKey, token!);
  }

  bool get isLogin => token != null;

  void removeToken() {
    _prefs?.remove(tokenKey);
  }

  //user Id//
  String? get userId => _prefs!.getString(userIdKey);

  set userId(String? token) {
    _prefs?.setString(userIdKey, token!);
  }

  void removeUserId() {
    _prefs?.remove(userIdKey);
  }

  // User //
  UserModel? get user {
    try {
      if (_prefs!.containsKey(userKey)) {
        final jsonData = jsonDecode(_prefs!.getString(userKey)!);
        return UserModel.fromJson(jsonData);
      } else {
        return null;
      }
    } catch (e) {
      log("error decode user prefs", error: e);
      return null;
    }
  }

  set user(UserModel? user) {
    _prefs!.setString(userKey, jsonEncode(user!.toJson()));
  }

  void removeUser() {
    _prefs!.remove(userKey);
  }

  // Book Stats //
  int get bookStats => _prefs!.getInt(bookStatsKey) ?? 0;

  set bookStats(int count) {
    _prefs?.setInt(bookStatsKey, count);
  }

  //Remove all
  void removeAll() {
    removeToken();
    removeUserId();
    removeUser();
  }
}
