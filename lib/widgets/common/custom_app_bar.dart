import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study/configs/thems/ui_parameters.dart';
import 'package:study/screens/question/test_overview_screen.dart';
import 'package:study/widgets/app_circle_button.dart';

import '../../configs/thems/custom_text_style.dart';
import '../app_icon.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.title = '', this.showActionIcon = false, this.leading, this.titleWidget, this.onMenuActionTap});

  final String title;
  final Widget? titleWidget;
  final Widget? leading;
  final bool showActionIcon;
  final VoidCallback? onMenuActionTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: mobileScreenPadding, vertical: mobileScreenPadding),
        child: Stack(
          children: [
            Positioned.fill(
                child: titleWidget == null?Center(
                  child: Text(
                      title,
                    style: appBarTs,
                  ),
                ):Center(child: titleWidget,)
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                leading??Transform.translate(offset: const Offset(-14, 0),
                  child: BackButton(),
                ),
                if(showActionIcon)
                  Transform.translate(offset: const Offset(10, 0),
                    child: AppCircleButton(
                      child: const Icon(AppIcons.menu),
                      onTap: onMenuActionTap??()=>Get.toNamed(TestOverviewScreen.routeName),
                    ),
                  ),


              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 80);
}
