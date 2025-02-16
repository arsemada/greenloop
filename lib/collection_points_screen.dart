import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CollectionPointsScreen extends StatelessWidget {
  const CollectionPointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Find Collection Points")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: LatLng(9.145, 40.4897), zoom: 12), // Ethiopia example
        markers: {
          Marker(markerId: MarkerId("1"), position: LatLng(9.05, 40.45), infoWindow: InfoWindow(title: "Recycling Station")),
        },
      ),
    );
  }
}
