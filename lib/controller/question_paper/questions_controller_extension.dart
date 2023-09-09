import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:study/controller/question_paper/question_controller.dart';

import '../../firebase_ref/references.dart';
import '../auth_controller.dart';

extension QuestionsControllerExtension on QuestionController{


  int get correctQuestionCount => allQuestions.where((element) => element.selectedAnswer == element.correctAnswer).toList().length;

  String get correctAnsweredQuestion{
    return '$correctQuestionCount out of ${allQuestions.length} are correct';
  }

  String get points{
    var points = (correctQuestionCount/allQuestions.length)*100*(questionPaperModel.timeSeconds - remainSeconds)/questionPaperModel.timeSeconds*100;
    return points.toStringAsFixed(2);
  }


  Future<void> saveTestResults() async {
    var batch = fireStore.batch();
    User? _user = Get.find<AuthController>().getUser();
    if(_user == null)
      return;
    batch.set(userRF.doc(_user.email).collection('myrecent_tests').doc(questionPaperModel.id), {

      "points": points,
      "correct_answer": '$correctQuestionCount/${allQuestions.length}',
      "question_id":questionPaperModel.id,
      "time": questionPaperModel.timeSeconds - remainSeconds
    }
    );
    batch.commit();
    navigateToHome();
  }
}

