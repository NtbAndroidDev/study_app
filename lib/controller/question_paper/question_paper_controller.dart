import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:study/controller/auth_controller.dart';
import 'package:study/firebase_ref/references.dart';
import 'package:study/models/question_paper_models.dart';

import '../../screens/question/questions_screen.dart';
import '../../services/firebase_storage_service.dart';

class QuizPaperController extends GetxController {
  final allPaperImages = <String>[].obs;
  final allPapers = <QuestionPaperModels>[].obs;

  @override
  void onReady() {
    getAllPapers();
    super.onReady();
  }

  Future<void> getAllPapers() async {
    List<String> imgName = ['biology', 'chemistry', 'maths', 'physics'];
    try {

      QuerySnapshot<Map<String, dynamic>> data = await questionPaperRF.get(); 
      final paperList = data.docs.map((paper) => QuestionPaperModels.fromSnapshot(paper)).toList();
      allPapers.assignAll(paperList);

      for (var paper in paperList) {
        final imgUrl = await Get.find<FirebaseStorageService>().getImage(paper.title);
        paper.imageUrl = imgUrl;
        // allPaperImages.add(imgUrl!);
      }
      allPapers.assignAll(paperList);
    } catch (e) {
      print(e);
      print("hahahahaha");
    }
  }
  void navigateToQuestions({required QuestionPaperModels paper, bool tryAgain = false}){
    AuthController _authController = Get.find();
    if(_authController.isLoggedIn()){
      if(tryAgain){
        Get.back();
        Get.offNamed(QuestionsScreen.routeName, arguments: paper, preventDuplicates: false);
      }else{
        Get.offAndToNamed(QuestionsScreen.routeName, arguments: paper);
      }

    }else{
      print(paper.title);
      _authController.showLoginAlertDialogue();

    }
  }
}
