import 'package:get/get.dart';
import 'package:study/controller/auth_controller.dart';
import 'package:study/controller/theme_controller.dart';

import '../services/firebase_storage_service.dart';

class InitialBindings implements Bindings{
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(AuthController(), permanent: true);
    Get.lazyPut(() =>  FirebaseStorageService());
    Get.put(FirebaseStorageService());

  }

}