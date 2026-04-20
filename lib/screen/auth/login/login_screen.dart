import 'package:my_project/base/base_page.dart';
import 'package:my_project/router/app_router.dart';
import 'package:my_project/screen/auth/login/login_vm.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with BasePage<LoginVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => Scaffold(),
    );
  }

  @override
  LoginVM create() => LoginVM();

  @override
  void initialise(BuildContext context) {}
}
