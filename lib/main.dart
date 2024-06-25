import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_sphere/models/notemodel.dart';
import 'package:note_sphere/models/todomodel.dart';
import 'package:note_sphere/routes/routings.dart';
import 'package:note_sphere/util/themedata.dart';

void main() async {
  //initilize hive in flutter
  await Hive.initFlutter();

  //register adapters to database
  Hive.registerAdapter(NoteModelAdapter());
  Hive.registerAdapter(ToDoModelAdapter());

  //create boxes to store the data
  await Hive.openBox("notebox");
  await Hive.openBox("todobox");
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
