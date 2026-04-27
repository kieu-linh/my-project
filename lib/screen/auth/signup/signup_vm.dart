import 'package:dio/dio.dart';
import 'package:my_project/base/base_view_model.dart';
import 'package:my_project/utils/messages.dart';
import 'package:flutter/material.dart';

class SignupVM extends BaseViewModel {
  @override
  void onInit() {}
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;
  String? name, email, password, phone;

  VoidCallback? onRegisterSuccess;

  void visiblePassword() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void register() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      showLoading();
      try {
        final res = await api.authRepo.signup(email!, password!, name!, phone!);
        hideLoading();
        if (res.statusCode >= 200 && res.statusCode < 300) {
          showNotification('memberCreated');
          onRegisterSuccess?.call();
        }
      } catch (e) {
        hideLoading();
        if (e is DioError && e.response?.statusCode == 422) {
          showError('Email already exists');
        } else {
          showError(Messages.serverError);
        }
      }
    }
  }
}
