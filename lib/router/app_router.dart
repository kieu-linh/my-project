import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_project/models/book.dart';
import 'package:my_project/router/app_router_observer.dart';
import 'package:my_project/screen/auth/login/login_screen.dart';
import 'package:my_project/screen/auth/signup/signup_screen.dart';
import 'package:my_project/screen/book/book_form_screen.dart';
import 'package:my_project/screen/book/book_list_screen.dart';
import 'package:my_project/screen/borrow/borrow_list_screen.dart';
import 'package:my_project/screen/borrow/borrow_form_screen.dart';
import 'package:my_project/screen/dashboard/dashboard_screen.dart';
import 'package:my_project/screen/member/member_list_screen.dart';
import 'package:my_project/screen/member/member_form_screen.dart';
import 'package:my_project/screen/profile/profile_screen.dart';
import 'package:my_project/screen/main_shell.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();
  static final AppRouterObserver _routerObserver = AppRouterObserver();

  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/login',
    observers: [_routerObserver],
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
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            name: 'dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/books',
            name: 'books',
            builder: (context, state) => const BookListScreen(),
            routes: [
              GoRoute(
                path: 'add',
                name: 'addBook',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const BookFormScreen(),
              ),
              GoRoute(
                path: 'edit',
                name: 'editBook',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  final book = state.extra as Book?;
                  return BookFormScreen(book: book);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/members',
            name: 'members',
            builder: (context, state) => const MemberListScreen(),
            routes: [
              GoRoute(
                path: 'add',
                name: 'addMember',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const MemberFormScreen(),
              ),
              GoRoute(
                path: 'edit',
                name: 'editMember',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  final member = state.extra as dynamic;
                  return MemberFormScreen(member: member);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/borrows',
            name: 'borrows',
            builder: (context, state) => const BorrowListScreen(),
            routes: [
              GoRoute(
                path: 'add',
                name: 'addBorrow',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const BorrowFormScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  );

  static void goLogin(BuildContext context) {
    context.goNamed('login');
  }

  static void goSignup(BuildContext context) {
    context.goNamed('signup');
  }

  static void goDashboard(BuildContext context) {
    context.goNamed('dashboard');
  }

  static void goBooks(BuildContext context) {
    context.goNamed('books');
  }

  static void goAddBook(BuildContext context) {
    context.goNamed('addBook');
  }

  static void goEditBook(BuildContext context, Book book) {
    context.goNamed('editBook', extra: book);
  }

  static void goMembers(BuildContext context) {
    context.goNamed('members');
  }

  static void goAddMember(BuildContext context) {
    context.goNamed('addMember');
  }

  static void goEditMember(BuildContext context, dynamic member) {
    context.goNamed('editMember', extra: member);
  }

  static void goBorrows(BuildContext context) {
    context.goNamed('borrows');
  }

  static void goAddBorrow(BuildContext context) {
    context.goNamed('addBorrow');
  }

  static void goProfile(BuildContext context) {
    context.goNamed('profile');
  }
}
