import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_sphere/pages/completed_todopage.dart';
import 'package:note_sphere/pages/incomplete_todopage.dart';
import 'package:note_sphere/routes/routenames.dart';
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

  @override
  void initState() {
    //initilize the tab controller
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
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
        onPressed: () {},
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
