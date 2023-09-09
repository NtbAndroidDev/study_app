import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:study/bindings/initial_bindings.dart';
import 'package:study/configs/thems/app_dark_theme.dart';
import 'package:study/configs/thems/app_light_theme.dart';
import 'package:study/controller/question_paper/data_uploader_screen.dart';
import 'package:study/controller/theme_controller.dart';
import 'package:study/routes/app_routes.dart';
import 'package:study/screens/introduction/introduction.dart';
import 'package:study/screens/splash/splash_screen.dart';

import 'firebase_options.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  InitialBindings().dependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Get.find<ThemeController>().lightTheme, //light
      // theme: DarkTheme().buildDarkTheme(), //dark
      getPages: AppRoutes.routes(),


    );
  }
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(GetMaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: DataUploaderScreen()
//   )
//   );
// }


