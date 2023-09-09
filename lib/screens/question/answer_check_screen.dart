import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study/configs/thems/custom_text_style.dart';
import 'package:study/controller/question_paper/question_controller.dart';
import 'package:study/screens/question/result_screen.dart';
import 'package:study/widgets/common/background_decoration.dart';
import 'package:study/widgets/common/custom_app_bar.dart';

import '../../configs/thems/app_colors.dart';
import '../../configs/thems/ui_parameters.dart';
import '../../firebase_ref/loading_status.dart';
import '../../widgets/common/main_button.dart';
import '../../widgets/common/question_place_holder.dart';
import '../../widgets/content_area.dart';
import '../../widgets/questions/answer_card.dart';

class AnswerCheckScreen extends GetView<QuestionController> {
  const AnswerCheckScreen({super.key});


  static const String routeName = "/answercheckscreen";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleWidget: Obx(() => Text('Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, "0")}', style: appBarTs,)),
        showActionIcon: true,
        onMenuActionTap: (){
          Get.toNamed(ResultScreen.routeName);

        },
      ),
      body: BackgroundDecoration(
        child: Obx(() =>  Column(
          children: [
            if(controller.loadingStatus.value == LoadingStatus.loading)
              const Expanded(child: ContentArea(child: QuestionScreenHolder())),

            if(controller.loadingStatus.value == LoadingStatus.completed)
              Expanded(child: ContentArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: 25),
                  child: Column(
                    children: [
                      Text(
                        controller.currentQuestion.value!.question!,
                        style: questionTS,
                      ),
                      GetBuilder<QuestionController>(
                          id: 'answers_review_list',
                          builder: (context){
                            return ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.only(top: 25),
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: ( _, int i){
                                  final answer =  controller.currentQuestion.value!.answers[i];
                                  final selectedAnswer = controller.currentQuestion.value!.selectedAnswer;
                                  final correctAnswer = controller.currentQuestion.value!.correctAnswer;
                                  final String answerText = '${answer.identifier}. ${answer.answer}';
                                  if(correctAnswer == selectedAnswer && answer.identifier == selectedAnswer){
                                    //correct answer
                                    return CorrectAnswer(answer: answerText);
                                  }else if(selectedAnswer == null){
                                    //not selected
                                    return NotAnswered(answer: answerText);
                                  }else if(correctAnswer != selectedAnswer && answer.identifier == selectedAnswer){
                                    //wrong answer
                                    return WrongAnswer(answer: answerText);
                                  }else if(correctAnswer == answer.identifier){
                                    //correct answer
                                    return CorrectAnswer(answer: answerText);
                                  }
                                  return AnswerCard(
                                    answer: answerText,
                                    onTap: (){
                                      // controller.selectedAnswer(answer.identifier);
                                    },
                                    isSelected: false,
                                  );
                                },
                                separatorBuilder: ( _, int i) => const SizedBox(height: 10),
                                itemCount: controller.currentQuestion.value!.answers.length
                            );
                          }
                      ),

                    ],
                  ),
                ),
              )),


          ],
        )),
      ),

    );

  }
}

