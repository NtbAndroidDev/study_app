import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:study/widgets/app_circle_button.dart';

import '../../configs/thems/app_colors.dart';

class AppIntroductionScreen extends StatelessWidget {
  const AppIntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: mainGradient()),
        alignment: Alignment.center,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Get.width*0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                  Icons.star,
                size: 65
              ),
              SizedBox(height: 40),
              const Text(
                "This is a study app. You can use it as you want. If you understand how it works you would be able to scale it. With this you will master firebase backend and flutter front end.",
                style: TextStyle(
                  fontSize: 18,
                  color: onSurfaceTextColor,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              AppCircleButton(
                onTap: ()=> {
                  Get.offAndToNamed("/home")
                },
                child: const Icon(Icons.arrow_forward, size: 35),
              )
            ],
          ),
        ),
      ),
    );
  }
}
