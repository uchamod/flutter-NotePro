import 'package:flutter/material.dart';
import 'package:note_sphere/util/colors.dart';
import 'package:note_sphere/util/textstyle.dart';

class ErroPage extends StatefulWidget {
  const ErroPage({super.key});

  @override
  State<ErroPage> createState() => _ErroPageState();
}

class _ErroPageState extends State<ErroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("WOOPS!",style: TextStyleClass.appHeadingStyle.copyWith(
                fontSize: 62,fontWeight: FontWeight.w400,color: AppColors.readmoreblue

            ),),
            const SizedBox(height: 15,),
            Image.network("https://cdn.dribbble.com/users/1138875/screenshots/4669703/404_animation.gif"),


          ],
        ),
      ),
    );
  }
}
