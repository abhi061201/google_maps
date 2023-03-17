import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class map_widget extends StatelessWidget {
  const map_widget({super.key});
  static final CameraPosition _currentPosition = CameraPosition(
    target: LatLng(25.469660, 78.643777),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: _currentPosition,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      compassEnabled: false,
      
      
    );
  }
}
