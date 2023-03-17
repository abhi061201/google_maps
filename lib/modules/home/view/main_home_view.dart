import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_maps/modules/home/widget/google_map_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Main_home_view extends StatelessWidget {
  Main_home_view({super.key, required this.userInfo});
  Map<String, dynamic> userInfo = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello ' + userInfo['first name']),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            // height: Get.height,
            child: Expanded(
              child: map_widget(),
            ),
          ),
        ],
      ),
    );
  }
}
