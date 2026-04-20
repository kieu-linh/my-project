import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_project/screen/auth/login/login_screen.dart';
import 'package:my_project/screen/auth/signup/signup_screen.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignUp(),
      ),
    ],
  );

  static void goLogin(BuildContext context) {
    context.goNamed('login');
  }

  static void goSignup(BuildContext context) {
    context.goNamed('signup');
  }
}
