import 'package:flutter/material.dart';

class AppRouterObserver extends NavigatorObserver {
  static final AppRouterObserver _instance = AppRouterObserver._internal();
  factory AppRouterObserver() => _instance;
  AppRouterObserver._internal();

  String? _currentRoute;
  final List<String> _routeHistory = [];

  String? get currentRoute => _currentRoute;
  List<String> get routeHistory => List.unmodifiable(_routeHistory);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _updateRoute(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (_routeHistory.isNotEmpty) {
      _routeHistory.removeLast();
    }
    _currentRoute = _routeHistory.isNotEmpty ? _routeHistory.last : null;
    _logRoute('Popped to', route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      _updateRoute(newRoute);
    }
  }

  void _updateRoute(Route<dynamic> route) {
    final routeName = route.settings.name ?? 'unnamed';
    _currentRoute = routeName;
    _routeHistory.add(routeName);
    _logRoute('Navigated to', route);
  }

  void _logRoute(String action, Route<dynamic> route) {
    final routeName = route.settings.name ?? 'unnamed';
    final arguments = route.settings.arguments;
    debugPrint('🔔 $action: $routeName${arguments != null ? ' | args: $arguments' : ''}');
  }

  void clearHistory() {
    _routeHistory.clear();
    _currentRoute = null;
  }
}
