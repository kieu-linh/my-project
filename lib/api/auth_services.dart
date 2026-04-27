import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:my_project/api/api_config.dart';

abstract class AuthRepo {
  factory AuthRepo(Dio dio) = _AuthServices;
  Future<dynamic> login(String email, String password);
  Future<dynamic> signup(
      String email, String password, String name, String address);
}

class _AuthServices implements AuthRepo {
  _AuthServices(this._dio);
  final Dio _dio;

  @override
  Future login(String email, password) async {
    try {
      final res = await _dio.post(
        ApiConfig.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      return res;
    } catch (e) {
      log("error api call login", error: e);
      return false;
    }
  }

  @override
  Future signup(
      String email, String password, String name, String phone) async {
    try {
      final res = await _dio.post(
        ApiConfig.signup,
        data: {
          'email': email,
          'password': password,
          'name': name,
          'phone': phone,
        },
      );
      return res;
    } catch (e) {
      log("error api call signup", error: e);
      return false;
    }
  }
}
