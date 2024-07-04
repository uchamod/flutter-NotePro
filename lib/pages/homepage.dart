import 'package:flutter/material.dart';
import 'package:note_sphere/ingerited/todo_inherited_widget.dart';
import 'package:note_sphere/models/notemodel.dart';
import 'package:note_sphere/models/todomodel.dart';
import 'package:note_sphere/routes/routenames.dart';
import 'package:note_sphere/routes/routings.dart';
import 'package:note_sphere/services/noteservices.dart';
import 'package:note_sphere/services/todoservice.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/constants.dart';
import 'package:note_sphere/util/textstyle.dart';
import 'package:note_sphere/widget/categorycard.dart';
import 'package:note_sphere/widget/progresscard.dart';
import 'package:note_sphere/widget/taskcard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NoteModel> notes = [];
  List<ToDoModel> todos = [];

  List<String> notesByCategory = [];
  @override
  void initState() {
    setState(() {
      _isNewUser();
      _loadNoteAndTodos();
    });
    super.initState();
  }

  //check if user new
  void _isNewUser() async {
    final bool isNew =
        await NoteServices().isNewUser() || await TodoService().isNewUser();
    if (isNew) {
      await NoteServices().saveInitialNotes();
      await TodoService().saveInitialTodos();
    }
  }

  //load all the cyrrent todos and notes
  void _loadNoteAndTodos() async {
    List<NoteModel> allnotes = await NoteServices().loadNotes();
    List<ToDoModel> alltodos = await TodoService().loadTodos();
    List<String> allNotesBycategory = await NoteServices().getAllCategories();

    setState(() {
      notes = allnotes;
      todos = alltodos;

      notesByCategory = allNotesBycategory;
    });
  }

  @override
  Widget build(BuildContext context) {
    //wrap with inherit widget
    return ToDoData(
      todos: todos,
      onToDoChanged: _loadNoteAndTodos,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "NotePro",
            style: TextStyleClass.appHeadingStyle,
          ),
        ),
        body: Padding(
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
                height: 30,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today's Progress",
                    style: TextStyleClass.appTittleStyle,
                  ),
                  Text(
                    "See All",
                    style: TextStyleClass.appSubTittleStyle,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 400,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: todos.length,
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
            ],
          ),
        ),
      ),
    );
  }
}
