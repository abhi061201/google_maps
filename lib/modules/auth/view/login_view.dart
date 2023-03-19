import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_truecaller/flutter_truecaller.dart';
import 'package:get/get.dart';
import 'package:google_maps/modules/auth/controllers/auth_controller.dart';
import 'package:google_maps/modules/auth/mobile_auth/mobile_auth.dart';
import 'package:google_maps/modules/auth/view/register_view.dart';
import 'package:google_maps/modules/home/view/main_home_view.dart';
import 'package:truecaller_sdk/truecaller_sdk.dart';

class login_view extends StatefulWidget {
  const login_view({super.key});

  @override
  State<login_view> createState() => _login_viewState();
}

class _login_viewState extends State<login_view> {
  final auth_controller = Get.put(authController());

  late StreamSubscription<TruecallerSdkCallback> stream;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getTruecaller();
  }

  Future getTruecaller() async {
    await TruecallerSdk.initializeSDK(
      sdkOptions: TruecallerSdkScope.SDK_OPTION_WITH_OTP,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image(
                    image: AssetImage(
                      'assets/images/login_girl.png',
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                Container(
                  child: Column(children: [
                    Text(
                      'Welcome to Jhoice',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    Text(
                      'Create your account now',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(
                      height: Get.height * 0.035,
                    ),
                    Text(
                      'Our registration process is quick and easy, taking',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'no more 10 minutes to complete',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ]),
                ),
                SizedBox(
                  height: Get.height * 0.17,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          debugPrint('Sign in is called');
                          TruecallerSdk.initializeSDK(
                              sdkOptions:
                                  TruecallerSdkScope.SDK_OPTION_WITHOUT_OTP);
                          // check krne k liye k truecaller install h bhi h ya nhi
                          TruecallerSdk.isUsable.then((isUsable) {
                            if (isUsable) {
                              TruecallerSdk.getProfile;
                            } else
                              Get.snackbar(
                                  "Error", "Please install truecaller");
                          });
                          // stream idhr ek truecaller vali stream ka obj h , isme saara data h
                          stream = TruecallerSdk.streamCallbackData
                              .listen((truecallerCallbackData) async {
                            switch (truecallerCallbackData.result) {
                              case TruecallerSdkCallbackResult.success:
                                {
                                  Map<String, dynamic> profileData = {};
                                  profileData['first name'] =
                                      truecallerCallbackData!
                                          .profile!.firstName;
                                  profileData['last name'] =
                                      truecallerCallbackData!.profile!.lastName;
                                  profileData['email'] =
                                      truecallerCallbackData!.profile!.email;
                                  profileData['avatar'] =
                                      truecallerCallbackData.profile!.avatarUrl;
                                  profileData['token'] =
                                      truecallerCallbackData!.accessToken;
                                  profileData['phoneNumber'] =
                                      truecallerCallbackData!
                                          .profile!.phoneNumber;

                                  debugPrint('User data Success');
                                  // debugPrint(truecallerCallbackData!.profile!.accessToken.toString());
                                  auth_controller.firebaseLogin(profileData);
                                  break;
                                }
                              case TruecallerSdkCallbackResult.verification:
                                {
                                  Get.snackbar('Verification Required',
                                      'Your Phone number needs to be verified.',
                                      snackPosition: SnackPosition.BOTTOM);
                                  Get.to(mobile_auth());
                                  break;
                                }
                              default:
                                {
                                  Get.snackbar(
                                      'Authentication failed', "Try again",
                                      snackPosition: SnackPosition.BOTTOM);
                                  break;
                                }
                            }
                          });
                        },
                        child: Container(
                          width: 114,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            color: Color(0xff28E9C8),
                          ),
                          child: Center(
                              child: Text(
                            'Sign in',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 1,
                      ),
                      InkWell(
                        onTap: () {
                          debugPrint('Sign Up is called');
                          Get.to(Register_view());
                        },
                        child: Container(
                          width: 114,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            color: Color(0xff44F6D8),
                          ),
                          child: Center(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
          );
  }
}
