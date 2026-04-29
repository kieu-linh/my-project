import 'dart:math';

import 'package:dio/dio.dart';
import 'package:my_project/base/base_view_model.dart';
import 'package:my_project/model/auth_response_model.dart';
import 'package:my_project/router/app_router.dart';
import 'package:my_project/utils/messages.dart';
import 'package:flutter/material.dart';

class LoginVM extends BaseViewModel {
  @override
  void onInit() {}
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;
  String? email, password;
  BuildContext? _context;

  void setContext(BuildContext context) {
    _context = context;
  }

  void visiblePassword() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      showLoading();
      try {
        final res = await api.authRepo.login(email!, password!);
        hideLoading();
        if (res.statusCode >= 200 && res.statusCode < 300) {
          final authResponse = AuthResponseModel.fromJson(res.data);
          prefs.token = authResponse.token;
          prefs.user = authResponse.user;
          showNotification('Login successful');
          if (_context != null) {
            AppRouter.goBooks(_context!);
          }
        } else {
          showNotification(res.error.toString());
        }
      } catch (e) {
        hideLoading();
        if (e is DioError && e.response?.statusCode == 401) {
          showError('Invalid credentials');
        } else {
          showError(Messages.serverError);
        }
      }
    }
  }
}
