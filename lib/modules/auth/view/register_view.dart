import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_maps/modules/auth/controllers/auth_controller.dart';
import 'package:google_maps/modules/auth/view/login_view.dart';
import 'package:truecaller_sdk/truecaller_sdk.dart';

class Register_view extends StatelessWidget {
  Register_view({super.key});
  late StreamSubscription<TruecallerSdkCallback> stream;
  final controller = Get.put(authController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            children: [
              Spacer(),
              Container(
                height: Get.height * 0.5,
                width: Get.width,
                decoration: BoxDecoration(color: Color(0xff28E9C8)),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: Get.height * 0.22,
              ),
              Image(image: AssetImage('assets/images/ell2.png')),
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: 135,
              ),
              Image(image: AssetImage('assets/images/ellipse.png')),
            ],
          ),
          Column(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 45),
                  child: Image(
                      image: AssetImage('assets/images/register_girl.png'))),
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: Get.height * 0.6,
              ),
              Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 40),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Get Started',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        const Text(
                          'Create your account now',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        const Text(
                          'by truecaller',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: Get.height * 0.08,
                        ),
                        InkWell(
                          onTap: () {
                            debugPrint('Register is called');
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
                                        truecallerCallbackData!
                                            .profile!.lastName;
                                    profileData['email'] =
                                        truecallerCallbackData!.profile!.email;
                                    profileData['avatar'] =
                                        truecallerCallbackData
                                            .profile!.avatarUrl;
                                    profileData['token'] =
                                        truecallerCallbackData!.accessToken;
                                    profileData['phoneNumber'] =
                                        truecallerCallbackData!
                                            .profile!.phoneNumber;

                                    debugPrint('User data Success');
                                    // debugPrint(truecallerCallbackData!.profile!.accessToken.toString());
                                    controller.firebaseRegister(profileData);
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
                            height: Get.height * 0.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: const Center(
                              child: Text(
                                'Sign Up With Truecaller',
                                style: TextStyle(
                                    color: Color(0xff28E9C8),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text('Already have an account?',style: TextStyle(
                        //       fontSize: 12,
                              
                        //       color: Colors.black),),
                        //     TextButton(
                        //         onPressed: (() {
                        //           Get.off(login_view());
                        //         }), child: Text('Sign In',style: TextStyle(
                        //       fontSize: 12,
                        //       fontWeight: FontWeight.w600,
                        //       color: Colors.white),))
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
