import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:study/configs/thems/app_colors.dart';

class MainButton extends StatelessWidget {
  const MainButton(
      {super.key,
      this.title = '',
      required this.onTap,
      this.enable = true,
      this.child,
      this.color});

  final String title;
  final VoidCallback onTap;
  final enable;
  final Widget? child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        height: 55,
        child: InkWell(
          onTap: enable == false ? null : onTap,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: color??Theme.of(context).cardColor
            ),
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: child ??
                  Center(
                    child: Text(
                      title,
                      style:  TextStyle(
                          fontWeight: FontWeight.bold, color: Get.isDarkMode?onSurfaceTextColor:Theme.of(context).primaryColor),
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
