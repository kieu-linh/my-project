import 'package:my_project/base/base_page.dart';
import 'package:my_project/router/app_router.dart';
import 'package:my_project/screen/auth/signup/signup_vm.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with BasePage<SignupVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => AppRouter.goLogin(context),
          ),
        ),
      ),
    );
  }

  @override
  SignupVM create() => SignupVM();

  @override
  void initialise(BuildContext context) {
    provider.onRegisterSuccess = () {
      AppRouter.goLogin(context);
    };
  }
}
