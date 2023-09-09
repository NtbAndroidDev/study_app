import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:study/firebase_ref/references.dart';
import 'package:study/screens/home/home_screen.dart';
import 'package:study/screens/login/login_screen.dart';

import '../widgets/dialogs/dialogue_widget.dart';
class AuthController extends GetxController {
  @override
  void onReady() {
    initAuth();
    super.onReady();
  }

  late FirebaseAuth _auth;
  final _user = Rxn<User>();
  late Stream<User?> _authStateChanges;

  void initAuth() async {
    await Future.delayed(const Duration(seconds: 1));
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) {
      _user.value = user;
    });
    navigateToIntroduction();
  }



  signInWithGoogle() async {
    final _googleSignIn = GoogleSignIn();
    try{
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if(account != null){
        final _authAccount = await account.authentication;
        final _credential = GoogleAuthProvider.credential(
          idToken: _authAccount.idToken,
          accessToken: _authAccount.accessToken
        );
        await _auth.signInWithCredential(_credential);
        await saveUser(account);
        navigateToHomePage();
      }
    } on Exception catch(error){
      print(error);
    }
  }


  Future<void> signOut() async {
    print("sign out");
    try{
      await _auth.signOut();
      navigateToHomePage();
    }on FirebaseException catch(e){
      print(e);
    }
  }

  navigateToHomePage(){
    Get.offAllNamed(HomeScreen.routeName);
  }

  User? getUser(){
    _user.value = _auth.currentUser;
    return _user.value;
  }

  saveUser(GoogleSignInAccount account){
    userRF.doc(account.email).set({
      "email":account.email,
      "name": account.displayName,
      "profilepic": account.photoUrl
    });
  }


  void navigateToIntroduction() {
    Get.offAllNamed("/introduction");
  }


  void showLoginAlertDialogue(){
    Get.dialog(Dialogs.questionStartDialogue(onTap: (){
      Get.back();
      navigateToLoginPage();


    }),
      barrierDismissible: false
    );
  }
  navigateToLoginPage(){
    Get.toNamed(LoginScreen.routeName);
  }


  bool isLoggedIn(){
    return _auth.currentUser != null;
  }


}
