import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:study/firebase_ref/loading_status.dart';
import 'package:study/models/question_paper_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../firebase_ref/references.dart';
class DataUploader extends GetxController{
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs;


  Future<void> uploadData() async {
    loadingStatus.value = LoadingStatus.loading; //0
    final manifestContent = await DefaultAssetBundle.of(Get.context!).loadString("AssetManifest.json");
    json.encode(manifestContent);
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final papersInAssets = manifestMap.keys.where((path) => path.startsWith("assets/DB/paper") && path.contains(".json")).toList();
    // print(papersInAssets);

    List<QuestionPaperModels> questionPapers = [];
    for(var paper in papersInAssets){

      String strPaperContent = await rootBundle.loadString(paper);
      questionPapers.add(QuestionPaperModels.fromJson(json.decode(strPaperContent)));
      print(strPaperContent);
      print("item ${questionPapers.length}");

      var batch = FirebaseFirestore.instance.batch();

      for(var paper in questionPapers){
        batch.set(questionPaperRF.doc(paper.id), {
          "title": paper.title,
          "image_url": paper.imageUrl,
          "description": paper.description,
          "time_seconds": paper.timeSeconds,
          "questions_count": paper.questions == null?0:paper.questions!.length

        });

        for(var questions in paper.questions!){
          final questionPath = questionRF(paperId: paper.id, questionId: questions.id);
          batch.set(questionPath, {
            "question": questions.question,
            "correct_answer": questions.correctAnswer
          });

          for(var answer in questions.answers!){
            batch.set(questionPath.collection("answer").doc(answer.identifier), {
              "identifier": answer.identifier,
              "answer": answer.answer

            });
          }
        }

      }
      await batch.commit();
      loadingStatus.value = LoadingStatus.completed;
    }
  }
}