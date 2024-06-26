import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_sphere/models/notemodel.dart';
import 'package:note_sphere/pages/add_newnotepage.dart';
import 'package:note_sphere/pages/errorpage.dart';
import 'package:note_sphere/pages/homepage.dart';
import 'package:note_sphere/pages/main_notepage.dart';
import 'package:note_sphere/pages/show_fullnotepage.dart';
import 'package:note_sphere/pages/single_notepage.dart';
import 'package:note_sphere/pages/todopage.dart';
import 'package:note_sphere/pages/update_notepage.dart';
import 'package:note_sphere/routes/routenames.dart';

class RouteClass {
  static final router = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    initialLocation: "/",
    errorPageBuilder: (context, state) {
      return const MaterialPage<dynamic>(child: ErroPage());
    },
    routes: [
      //for homepage
      GoRoute(
        path: "/",
        name: RouteNames.homepage,
        builder: (context, state) {
          return const HomePage();
        },
      ),
      //for notepage
      GoRoute(
        path: "/notepage",
        name: RouteNames.notepage,
        builder: (context, state) {
          return const MainNotePage();
        },
      ),
      //for todo page
      GoRoute(
        path: "/todopage",
        name: RouteNames.todopage,
        builder: (context, state) {
          return const ToDoPage();
        },
      ),
      //for single route page
      GoRoute(
        path: "/singlenotepage",
        name: RouteNames.singlenotepage,
        builder: (context, state) {
          String category = state.extra as String;
          return SingleNotePage(category: category);
        },
      ),
      //for add new note page
      GoRoute(
        path: "/addnewnote",
        name: RouteNames.addnewnotepage,
        builder: (context, state) {
          bool isNormal = state.extra as bool;
          return AddNewNote(
            isNormal: isNormal,
          );
        },
      ),
      //for note update page
      GoRoute(
        path: "/update",
        name: RouteNames.updatenotepage,
        builder: (context, state) {
          NoteModel note = state.extra as NoteModel;
          return UpdatenotePage(
            note: note,
          );
        },
      ),
      //for shoowfullnote page
      GoRoute(
        path: "/shownote",
        name: RouteNames.fullnotepage,
        builder: (context, state) {
          NoteModel note = state.extra as NoteModel;
          return ShowFullNote(
            note: note,
          );
        },
      ),
    ],
  );
}
