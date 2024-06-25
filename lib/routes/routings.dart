import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_sphere/pages/homepage.dart';
import 'package:note_sphere/pages/main_notepage.dart';
import 'package:note_sphere/pages/single_notepage.dart';
import 'package:note_sphere/pages/todopage.dart';
import 'package:note_sphere/routes/routenames.dart';

class RouteClass {
  static final router = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    initialLocation: "/",
    
    routes: [
      GoRoute(
        path: "/",
        name: RouteNames.homepage,
        builder: (context, state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: "/notepage",
        name: RouteNames.notepage,
        builder: (context, state) {
          return const MainNotePage();
        },
      ),
      GoRoute(
        path: "/todopage",
        name: RouteNames.todopage,
        builder: (context, state) {
          return const ToDoPage();
        },
      ),
      GoRoute(
        path: "/singlenotepage",
        name: RouteNames.singlenotepage,
        builder: (context, state) {
          //return const SingleNotePage(category: category);
        },
      )
    ],
  );
}
