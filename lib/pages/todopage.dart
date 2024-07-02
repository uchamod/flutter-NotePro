import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_sphere/models/todomodel.dart';
import 'package:note_sphere/pages/completed_todopage.dart';
import 'package:note_sphere/pages/incomplete_todopage.dart';
import 'package:note_sphere/routes/routenames.dart';
import 'package:note_sphere/services/todoservice.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/textstyle.dart';

//todo-page using tab bar
class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

//activate the tabcontroller using SingleTickerProviderStateMixin
class _ToDoPageState extends State<ToDoPage>
    with SingleTickerProviderStateMixin {
  //tabbar controller : identify the tabs
  late TabController _tabController;
  TextEditingController _controller = TextEditingController();
  TodoService _todoService = TodoService();
  @override
  void initState() {
    //initilize the tab controller
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _addNewTask(ToDoModel todo, BuildContext context) async {
    if (todo.title.isNotEmpty) {
      await _todoService.addNewTodo(todo, context);
    }

    Navigator.of(context).pop();
    GoRouter.of(context).goNamed(RouteNames.todopage);
    _controller.clear();
    setState(() {
      const IncompleteToDo();
    });
  }

  //todo adding disalog box
  void _openDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 2,
          shadowColor: AppColors.kcTextWhiteColorShadow,
          backgroundColor: AppColors.kcCardBlackColor,
          title: const Text(
            "Add Task",
            style: TextStyleClass.appTittleStyle,
          ),
          content: TextField(
            cursorColor: AppColors.kcTextWhiteColor,
            controller: _controller,
            style: TextStyleClass.appSubTittleStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: AppColors.kcTextWhiteColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: AppColors.kcTextWhiteColor),
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      AppColors.kcBackgroundBlackColor.withOpacity(0.1),
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  //add new task
                  onPressed: () {
                    _addNewTask(
                        ToDoModel(
                            time: DateTime.now(),
                            title: _controller.text,
                            date: DateTime.now(),
                            markAsDone: false),
                        context);
                  },
                  child: const Text(
                    "Add Task",
                    style: TextStyleClass.appSubTittleStyle,
                  ),
                ),
                TextButton(
                  //cancel the task card
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyleClass.appSubTittleStyle,
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            GoRouter.of(context).goNamed(RouteNames.homepage);
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            size: 30,
          ),
        ),

        //add shiftable tab bar to the appbar
        bottom: TabBar(
          controller: _tabController,
          dividerColor: AppColors.kcCardBlackColor,
          indicatorColor: AppColors.kcTextWhiteColor,
          automaticIndicatorColorAdjustment: true,
          tabs: const [
            Tab(
              child: Text(
                "ToDo",
                style: TextStyleClass.appTittleStyle,
              ),
            ),
            Tab(
              child: Text(
                "Completed",
                style: TextStyleClass.appTittleStyle,
              ),
            )
          ],
        ),
      ),
      //add tab viwes
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        //show bottom sheet
        onPressed: () {
          _openDialogBox(context);
        },
        child: const Center(
          child: Icon(
            Icons.add,
            size: 35,
            color: AppColors.kcTextWhiteColor,
          ),
        ),
      ),
      body: TabBarView(controller: _tabController, children: const [
        IncompleteToDo(),
        CompletedToDo(),
      ]),
    );
  }
}
