import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:study/controller/question_paper/question_controller.dart';
import 'package:study/controller/question_paper/question_paper_controller.dart';
import 'package:study/controller/zoom_drawer_controller.dart';
import 'package:study/screens/home/home_screen.dart';
import 'package:study/screens/introduction/introduction.dart';
import 'package:study/screens/login/login_screen.dart';
import 'package:study/screens/question/questions_screen.dart';
import 'package:study/screens/question/result_screen.dart';

import '../screens/question/answer_check_screen.dart';
import '../screens/question/test_overview_screen.dart';
import '../screens/splash/splash_screen.dart';

class AppRoutes{

  static List<GetPage> routes() => [
    GetPage(name: "/", page: ()=> SplashScreen()),
    GetPage(name: "/introduction", page: ()=> AppIntroductionScreen()),
    GetPage(
        name: "/home",
        page: () => const HomeScreen(),
        binding: BindingsBuilder(() {
          Get.put(QuizPaperController());
          Get.put(MyZoomDrawerController());
        })),

    GetPage(name: LoginScreen.routeName, page: ()=> const LoginScreen()),
    GetPage(name: QuestionsScreen.routeName, page: ()=> const QuestionsScreen(), binding: BindingsBuilder ((){
      Get.put<QuestionController>(QuestionController());
    })),
    GetPage(name: TestOverviewScreen.routeName, page: ()=> const TestOverviewScreen()),
    GetPage(name: ResultScreen.routeName, page: ()=> const ResultScreen()),
    GetPage(name: AnswerCheckScreen.routeName, page: ()=> const AnswerCheckScreen())
  ];
}