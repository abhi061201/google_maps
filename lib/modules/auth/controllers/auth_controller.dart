import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_maps/modules/home/view/main_home_view.dart';

class authController extends GetxController {
  @override
  FirebaseAuth auth = FirebaseAuth.instance;
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future firebaseLogin(Map<String, dynamic> userInfo) async {
    // debugPrint('put firebase login here');
    // debugPrint(userInfo['first name']);
    // debugPrint(userInfo['email']);
    // debugPrint(userInfo['phoneNumber']);
    String my_email =
        "jhoice" + userInfo['phoneNumber'].substring(3) + "@gmail.com";

    try {
      auth
          .signInWithEmailAndPassword(
              email: my_email, password: userInfo['phoneNumber'])
          .then((value) => Get.offAll(home_view(
                userInfo: userInfo,
              ))).onError((error, stackTrace) {
                Get.snackbar('Error', error.toString(), snackPosition: SnackPosition.BOTTOM);
              } );
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future firebaseRegister(Map<String, dynamic> userInfo) async {
    debugPrint(userInfo['email']);
    String my_email =
        "jhoice" + userInfo['phoneNumber'].substring(3) + "@gmail.com";

    debugPrint(my_email);

    try {
      auth
          .createUserWithEmailAndPassword(
              email: my_email, password: userInfo['phoneNumber'])
          .then((value) => {
                Get.snackbar('Congratulation', 'Registration successfull',
                    snackPosition: SnackPosition.BOTTOM)
              }).onError((error, stackTrace) => {
                Get.snackbar('Error', error.toString(), snackPosition: SnackPosition.BOTTOM)
              });
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}
