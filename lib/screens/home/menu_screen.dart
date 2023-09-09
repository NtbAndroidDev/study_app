import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:study/configs/thems/app_colors.dart';
import 'package:study/configs/thems/ui_parameters.dart';
import 'package:study/controller/zoom_drawer_controller.dart';
import 'package:study/widgets/app_icon.dart';

import '../login/login_screen.dart';

class MyMenuScreen extends GetView<MyZoomDrawerController> {
  const MyMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: UIParameters.mobileScreenPadding,
      width: double.maxFinite,
      decoration: BoxDecoration(
        gradient: mainGradient(),
      ),
      child: Theme(
        data: ThemeData(
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(primary: onSurfaceTextColor))),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  right: 0,
                  child: BackButton(
                    color: Colors.white,
                    onPressed: () {
                      controller.toggleDrawer();
                    },
                  )),
              Padding(
                padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => controller.user.value == null
                        ? const SizedBox()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: Get.width * 0.2,
                                width: Get.width * 0.2,
                                child: CachedNetworkImage(
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    margin: null,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(44)),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover)),
                                  ),
                                  imageUrl: controller.user.value!.photoURL!,
                                  placeholder: (context, url) => Container(
                                    alignment: Alignment.center,
                                    child: const CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) => Image.asset("assets/images/app_splash_logo.png"),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                controller.user.value!.displayName ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: onSurfaceTextColor,
                                    fontSize: 18),
                              ),
                            ],
                          )),
                    const Spacer(
                      flex: 1,
                    ),
                    _DrawerButton(
                      icon: AppIcons.github,
                      lable: "My Github",
                      onPressed: () => controller.github(),
                    ),//github
                    TextButton.icon(
                      onPressed: ()=> controller.dowload(),
                      icon: Icon(
                        Icons.code,
                        size: 22,
                      ),
                      label: Text("Donwload Soucre code"),
                    ),
                    _DrawerButton(
                      icon: AppIcons.contact,
                      lable: "Contact Me",
                      onPressed: (){

                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _DrawerButton(
                            icon: Icons.web,
                            lable: "website",
                            onPressed: () => controller.website(),
                          ),
                          _DrawerButton(
                            icon: Icons.facebook,
                            lable: "facbook",
                            onPressed: () => controller.website(),
                          ),
                          _DrawerButton(
                            icon: Icons.drafts,
                            lable: "email",
                            onPressed: () => controller.email(),
                          ),
                        ],
                      ),
                    ),

                    Spacer(
                      flex: 4,
                    ),
                    _DrawerButton(
                      icon: controller.user.value == null?Icons.login:AppIcons.logout,
                      lable: controller.user.value == null?"login":"logout",

                      onPressed: () => controller.user.value == null?Get.toNamed(LoginScreen.routeName):controller.signOut(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerButton extends StatelessWidget {
  const _DrawerButton(
      {super.key, required this.icon, required this.lable, this.onPressed});

  final IconData icon;
  final String lable;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 15,
      ),
      label: Text(lable),
    );
  }
}
