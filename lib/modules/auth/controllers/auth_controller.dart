import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_maps/modules/home/view/main_home_view.dart';

class authController extends GetxController{

@override
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

  Future firebaseLogin(Map<String, dynamic> userInfo)async
  {
    debugPrint('put firebase login here');
    debugPrint(userInfo['first name']);
    debugPrint(userInfo['email']);
    debugPrint(userInfo['phoneNumber']);
    
    Get.offAll(Main_home_view(userInfo:  userInfo,));
  }

  
  
}