import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({super.key});
  static final CameraPosition _currentPosition = CameraPosition(
    target: LatLng(  25.469660, 78.643777),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('google maps app')),
      body: GoogleMap(
        initialCameraPosition:_currentPosition ,
        
      ),
    );
  }
}