import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_truecaller/flutter_truecaller.dart';
import 'package:get/get.dart';
import 'package:google_maps/modules/auth/controllers/auth_controller.dart';
import 'package:google_maps/modules/auth/mobile_auth/mobile_auth.dart';
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
      appBar: AppBar(
        title: Text('Login view'),
        centerTitle: true,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () async {
                TruecallerSdk.initializeSDK(
                    sdkOptions: TruecallerSdkScope.SDK_OPTION_WITHOUT_OTP);

                // check krne k liye k truecaller install h bhi h ya nhi
                TruecallerSdk.isUsable.then((isUsable) {
                  if (isUsable) {
                    TruecallerSdk.getProfile;
                  } else
                    Get.snackbar("Error", "Please install truecaller");
                });

                // stream idhr ek truecaller vali stream ka obj h , isme saara data h
                stream = TruecallerSdk.streamCallbackData
                    .listen((truecallerCallbackData) async {
                  switch (truecallerCallbackData.result) {
                    case TruecallerSdkCallbackResult.success:
                      {
                        Map<String, dynamic> profileData = {};
                        profileData['first name'] =
                            truecallerCallbackData!.profile!.firstName;
                        profileData['last name'] =
                            truecallerCallbackData!.profile!.lastName;
                        profileData['email'] =
                            truecallerCallbackData!.profile!.email;
                        profileData['avatar'] =
                            truecallerCallbackData.profile!.avatarUrl;
                        profileData['token'] =
                            truecallerCallbackData!.accessToken;
                        profileData['phoneNumber'] =
                            truecallerCallbackData!.profile!.phoneNumber;

                        debugPrint('User data Success');
                        auth_controller.firebaseLogin(profileData);
                        break;
                      }

                    case TruecallerSdkCallbackResult.verification:
                      {
                        Get.snackbar(
                          'Verification Required',
                          'Your Phone number needs to be verified.',
                        );
                        Get.to(mobile_auth());
                        break;
                      }
                    default:
                      {
                        Get.snackbar(
                          'Authentication failed',
                          "Error Code ${truecallerCallbackData.error!.code}",
                        );
                        break;
                      }
                  }
                });
              },
              child: Text('Login Truecaller'),
            )
          ]),
    );
  }
}
