import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapSampleState();
}

class MapSampleState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _mega = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(42.878580, 74.623675),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    getLocation();

    super.initState();
  }

  void getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      //nothing
    }
    //Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    //print(position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: {
          const Marker(
              markerId: MarkerId('1'), position: LatLng(42.878580, 74.623675))
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomGesturesEnabled: true,
        mapType: MapType.terrain,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToMegaLab,
        label: const Text('To the Mega'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToMegaLab() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_mega));
  }
}
