import 'dart:math';

import 'package:flutter/material.dart';
import 'package:note_sphere/models/todomodel.dart';
import 'package:note_sphere/providers/note_provider.dart';
import 'package:note_sphere/providers/todo_provider.dart';
import 'package:note_sphere/routes/routenames.dart';
import 'package:note_sphere/routes/routings.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/constants.dart';
import 'package:note_sphere/util/textstyle.dart';
import 'package:note_sphere/widget/categorycard.dart';
import 'package:note_sphere/widget/progresscard.dart';
import 'package:note_sphere/widget/taskcard.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isShowAllTodos = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "QuickNote",
          style: TextStyleClass.appHeadingStyle,
        ),
      ),
      body: Consumer2<TodoProvider, NoteProvider>(
        builder: (context, todoProvider, noteProvider, child) {
          final todos = todoProvider.todos;
          final notesByCategory = noteProvider.categories;

          return RefreshIndicator(
            color: AppColors.kcTextWhiteColor,
            backgroundColor:
                AppColors.kcBackgroundBlackColor.withValues(alpha: 0.3),
            onRefresh: () async {
              await Future.wait([
                todoProvider.loadTodos(),
                noteProvider.loadNotes(),
              ]);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: ConstantClass.kcDefultpadH,
                    vertical: ConstantClass.kcDefultpadV),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //progress card
                    ProgressCard(
                      allTask: todos.length,
                      completeTask:
                          todos.where((elemant) => elemant.markAsDone).length,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            RouteClass.router.pushNamed(RouteNames.notepage);
                          },
                          child: CategoryCard(
                            icon: Icons.bookmark_add_outlined,
                            title: "Notes",
                            numOfTasks: notesByCategory.length,
                            subText: "notes",
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            RouteClass.router.pushNamed(RouteNames.todopage);
                          },
                          child: CategoryCard(
                            icon: Icons.today_outlined,
                            title: "To-Do Lists",
                            numOfTasks: todos.length,
                            subText: "Tasks",
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Today's Progress",
                          style: TextStyleClass.appTittleStyle,
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isShowAllTodos = !isShowAllTodos;
                            });
                          },
                          child: Text(
                            isShowAllTodos ? "See Less" : "See All",
                            style: TextStyleClass.appSubTittleStyle,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          isShowAllTodos ? todos.length : min(4, todos.length),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        ToDoModel todo = todos[index];
                        return TaskCard(
                            isCompleted: todo.markAsDone,
                            title: todo.title,
                            dateTime: todo.date,
                            time: todo.time,
                            iconColor: todo.markAsDone == true
                                ? AppColors.kcTickGreenColor
                                : AppColors.kcTickRedColor);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
