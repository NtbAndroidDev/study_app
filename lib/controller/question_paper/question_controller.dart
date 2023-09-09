import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:study/controller/auth_controller.dart';
import 'package:study/controller/question_paper/question_paper_controller.dart';
import 'package:study/controller/question_paper/questions_controller_extension.dart';
import 'package:study/firebase_ref/loading_status.dart';
import 'package:study/firebase_ref/references.dart';
import 'package:study/models/question_paper_models.dart';
import 'package:study/screens/home/home_screen.dart';

import '../../screens/question/result_screen.dart';

class QuestionController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  late QuestionPaperModels questionPaperModel;
  final allQuestions = <Questions>[];
  final questionIndex = 0.obs;

  bool get isFirstQuestion => questionIndex.value > 0;

  bool get isLastQuestion => questionIndex.value >= allQuestions.length - 1;
  Rxn<Questions> currentQuestion = Rxn<Questions>();
  Timer? _timer;

  int remainSeconds = 1;

  final time = '00.00'.obs;


  @override
  void onReady() {
    final _questionPaper = Get.arguments as QuestionPaperModels;
    print(_questionPaper.title);
    loadData(_questionPaper);
    super.onReady();
  }

  Future<void> loadData(QuestionPaperModels paper) async {
    questionPaperModel = paper;
    loadingStatus.value = LoadingStatus.loading;

    try {
      final QuerySnapshot<Map<String, dynamic>> questionQuery =
      await questionPaperRF.doc(paper.id).collection("questions").get();
      final questions = questionQuery.docs
          .map((snapshot) => Questions.fromSnapshot(snapshot))
          .toList();

      paper.questions = questions;

      for (Questions _question in paper.questions!) {
        final QuerySnapshot<Map<String, dynamic>> answerQuery =
        await questionPaperRF
            .doc(paper.id)
            .collection("questions")
            .doc(_question.id)
            .collection("answer")
            .get();
        final answers = answerQuery.docs
            .map((answer) => Answers.fromSnapshot(answer))
            .toList();

        _question.answers = answers;
      }

      print("kkkkkkkkkkk");
      print(currentQuestion.value!.answers.length);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    if (paper.questions != null && paper.questions!.isNotEmpty) {
      allQuestions.assignAll(paper.questions!);
      currentQuestion.value = paper.questions![0];
      _startTimer(paper.timeSeconds);
      if (kDebugMode) {
        print(paper.questions![0].question);
      }

      loadingStatus.value = LoadingStatus.completed;
    } else {
      loadingStatus.value = LoadingStatus.error;
    }
  }

  void selectedAnswer(String? answer) {
    currentQuestion.value!.selectedAnswer = answer;
    update(['answers_list']);
  }

  String get completedTest {
    final answered = allQuestions
        .where((element) => element.selectedAnswer != null)
        .toList()
        .length;
    return "$answered out of ${allQuestions.length} answered";
  }

  void jumpToQuestion(int index, {bool isGoBack = true}) {
    questionIndex.value = index;
    currentQuestion.value = allQuestions[index];
    if (isGoBack) {
      Get.back();
    }
  }

  void nextQuestion() {
    if (questionIndex.value >= allQuestions.length - 1) {
      return;
    }
    questionIndex.value++;
    currentQuestion.value = allQuestions[questionIndex.value];
  }

  void prevQuestion() {
    if (questionIndex.value <= 0) {
      return;
    }
    questionIndex.value--;
    currentQuestion.value = allQuestions[questionIndex.value];
  }

  _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainSeconds = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      if (remainSeconds == 0) {
        timer.cancel();
      } else {
        int minues = remainSeconds ~/ 60;
        int seconds = remainSeconds % 60;
        time.value =
        "${minues.toString().padLeft(2, "0")}:${seconds.toString().padLeft(
            2, "0")}";
        remainSeconds--;
      }
    });
  }

  void complete() {
    _timer!.cancel();
    Get.offAndToNamed(ResultScreen.routeName);
  }

  void tryAgain() {
    Get.find<QuizPaperController>().navigateToQuestions(
        paper: questionPaperModel, tryAgain: true);
  }

  void navigateToHome() {
    _timer!.cancel();
    Get.offNamedUntil(HomeScreen.routeName, (route) => false);
  }
}
