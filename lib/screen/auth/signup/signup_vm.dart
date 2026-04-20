import 'package:my_project/base/base_view_model.dart';
import 'package:flutter/material.dart';

class SignupVM extends BaseViewModel {
  @override
  void onInit() {}
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;
  String? email, password, name, address;
  VoidCallback? onRegisterSuccess;
  void visiblePassword() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void register() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      showLoading();
    }
  }
}
