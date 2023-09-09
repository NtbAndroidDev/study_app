import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'auth_controller.dart';

class MyZoomDrawerController extends GetxController{
  final zoomDrawerController = ZoomDrawerController();
  Rxn<User?> user =Rxn();
  @override
  void onReady() {
    user.value = Get.find<AuthController>().getUser();
    super.onReady();
  }
  void toggleDrawer(){
    zoomDrawerController.toggle?.call();
    update();
  }

  Future<void> signOut() async {
    Get.find<AuthController>().signOut();
  }

  void website(){
    _launch("https://www.facebook.com/b6112002");
  }
  void github(){
    _launch("https://github.com/NtbAndroidDev");
  }

  void dowload(){
    _launch("https://github.com/NtbAndroidDev/study_app/archive/refs/heads/master.zip");
  }
  void email(){
    final emailLaunchUri = Uri(
      scheme: "mailto",
      path: "thanhbinhntn2018@gmail.com"
    );
    _launch(emailLaunchUri.toString());
  }

  _launch(String url) async {

    if(!await launch(url)){
      throw 'could not launch $url';
    }
  }

}