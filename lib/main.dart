import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_sphere/routes/routings.dart';
import 'package:note_sphere/util/themedata.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //wrap with router
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      //add app theme with font family(inter) 
      theme: TheameClass.theameData.copyWith(
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
      ),
      title: "note shedule app",
      routerConfig: RouteClass.router,
    );
  }
}
