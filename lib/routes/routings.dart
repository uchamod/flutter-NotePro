import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_sphere/pages/homepage.dart';

class RouteClass {
  static final router = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    initialLocation: "/",
    
    routes: [
      GoRoute(
        path: "/",
        name: 'home',
        builder: (context, state) {
          return const HomePage();
        },
      )
    ],
  );
}
