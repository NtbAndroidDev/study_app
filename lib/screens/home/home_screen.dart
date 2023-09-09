import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:study/configs/thems/app_colors.dart';
import 'package:study/configs/thems/custom_text_style.dart';
import 'package:study/configs/thems/ui_parameters.dart';
import 'package:study/controller/question_paper/question_paper_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:study/controller/zoom_drawer_controller.dart';
import 'package:study/screens/home/menu_screen.dart';
import 'package:study/screens/home/question_card.dart';
import 'package:study/widgets/app_circle_button.dart';
import 'package:study/widgets/app_icon.dart';
import 'package:study/widgets/content_area.dart';

class HomeScreen extends GetView<MyZoomDrawerController> {
  const HomeScreen({super.key});
  static const String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    QuizPaperController _questionPaperController = Get.find();
    return Scaffold(
      body: GetBuilder<MyZoomDrawerController>(builder: (_){
        return ZoomDrawer(
          borderRadius: 50.0,
          showShadow: true,
          angle: 0.0,
          style: DrawerStyle.DefaultStyle,
          backgroundColor: Colors.white.withOpacity(0.5),
          slideWidth: MediaQuery.of(context).size.width*0.6,
          controller: _.zoomDrawerController,
            menuScreen:  MyMenuScreen(),
            mainScreen: Container(
              decoration: BoxDecoration(gradient:  mainGradient()),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(mobileScreenPadding),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            child: const Icon(AppIcons.menuLeft, ),
                            onTap: controller.toggleDrawer,
                          ),
                          const SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                const Icon(AppIcons.peace, ),
                                Text("Hello dastagir ahmed", style: detailText.copyWith(
                                    color:  onSurfaceTextColor
                                ),)
                              ],
                            ),
                          ),
                          Text(
                            "What do you want to learn to day?",
                            style: headerText,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ContentArea(
                          addPadding: false,
                          child: Obx(() => ListView.separated(
                              padding: UIParameters.mobileScreenPadding,
                              itemBuilder: (BuildContext context, int i){
                                return QuestionCard(model: _questionPaperController.allPapers[i]);
                              },
                              separatorBuilder: (BuildContext context, int i){
                                return const SizedBox(height: 20);
                              },
                              itemCount: _questionPaperController.allPapers.length)
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
        );
      },),
    );
  }
}
