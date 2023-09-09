import 'package:get/get.dart';
import 'package:study/firebase_ref/references.dart';


class FirebaseStorageService extends GetxService {
  Future<String?> getImage(String? imgName) async {
    if (imgName == null) {
      print("kkkkkkk");
      return null;
    }
    try {
      final urlRef = firebaseStorage
          .child('question_paper_images')
          .child('${imgName.toLowerCase()}.png');
      var imgUrl = await urlRef.getDownloadURL();
      return imgUrl;
    } catch (e) {
      print("hehehehehe");
      return null;
    }
  }
}
