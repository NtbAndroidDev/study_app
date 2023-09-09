import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final fireStore = FirebaseFirestore.instance;
final questionPaperRF = fireStore.collection('questionPapers');

Reference get firebaseStorage => FirebaseStorage.instance.ref();

final userRF = fireStore.collection("users");


DocumentReference questionRF({
   String? paperId,
   String? questionId,
}) => questionPaperRF.doc(paperId).collection("questions").doc(questionId);

