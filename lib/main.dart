import 'package:flutter/material.dart';

import 'package:note_sphere/routes/routings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "note shedule app",
     routerConfig: RouteClass.router,
    );
  }
}
