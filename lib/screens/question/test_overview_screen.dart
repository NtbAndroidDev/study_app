import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study/configs/thems/custom_text_style.dart';
import 'package:study/configs/thems/ui_parameters.dart';
import 'package:study/controller/question_paper/question_controller.dart';
import 'package:study/screens/home/question_card.dart';
import 'package:study/widgets/common/background_decoration.dart';
import 'package:study/widgets/common/custom_app_bar.dart';
import 'package:study/widgets/common/main_button.dart';
import 'package:study/widgets/content_area.dart';
import 'package:study/widgets/questions/answer_card.dart';
import 'package:study/widgets/questions/countdown_timer.dart';
import 'package:study/widgets/questions/question_number_card.dart';

import '../../configs/thems/app_colors.dart';

class TestOverviewScreen extends GetView<QuestionController> {
  const TestOverviewScreen({super.key});

  static const String routeName = "/testoverview";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: controller.completedTest,
      ),
      body: BackgroundDecoration(
        child: Column(
          children: [
            Expanded(
                child: ContentArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      CountdownTimer(
                        time: "",
                        color: UIParameters.isDarkMode()
                            ? Theme.of(context).textTheme.bodyText1!.color
                            : Theme.of(context).primaryColor,
                      ),
                      Obx(() => Text(
                            '${controller.time} Remaining',
                            style: countDownTimerTS(),
                          ))
                    ],
                  ),
                  SizedBox(height: 20),
                  Expanded(
                      child: GridView.builder(
                          itemCount: controller.allQuestions.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: Get.width ~/ 75,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8),
                          itemBuilder: (_, index) {
                            AnswerStatus? _answerStatus;
                            if(controller.allQuestions[index].selectedAnswer != null){
                              _answerStatus = AnswerStatus.answered;
                            }
                            return QuestionNumberCard(index: index + 1, status: _answerStatus, onTap: (){
                              controller.jumpToQuestion(index);
                            });
                          }))
                ],
              ),
            )),
            ColoredBox(
              color: customScaffoldColor(context),
              child: Padding(
                padding: UIParameters.mobileScreenPadding,
                child: MainButton(
                  onTap: (){
                    controller.complete();
                  },
                  title: 'Completed',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
