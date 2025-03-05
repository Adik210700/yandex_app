import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yandex_app/core/constans/app_dimensions.dart';
import 'package:yandex_app/core/extension/context_extension.dart';
import 'package:yandex_app/core/extension/double_extension.dart';
import 'package:yandex_app/modules/home/presentation/vidgets/map_textfield.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapSampleState();
}

class MapSampleState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final _pointAController = TextEditingController();
  final _pointBController = TextEditingController();

  LatLng pointA = const LatLng(42.878580, 74.623675);
  LatLng pointB = const LatLng(42.878580, 74.623675);

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

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
  void dispose() {
    _pointAController.dispose();
    _pointBController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            markers: {
              Marker(
                markerId: const MarkerId('1'),
                position: pointA,
              ),
              Marker(
                markerId: const MarkerId('2'),
                position: pointB,
              ),
            },
            onTap: (location) {
              log(location.toString());
              if (_pointAController.text.isEmpty) {
                pointA = location;
                _pointAController.text = location.toString();
              } else {
                pointB = location;
                _pointBController.text = location.toString();
                _getPolyline();
              }
              setState(() {});
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomGesturesEnabled: true,
            mapType: MapType.terrain,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            polylines: Set<Polyline>.of(polylines.values),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: AppDimensions.mediumPadding.paddingAll,
              height: context.mq.height * 0.25,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  color: Colors.white),
              child: Column(
                children: [
                  MapTextfield(
                    controller: _pointAController,
                  ),
                  AppDimensions.mediumPadding.verticalSpace,
                  MapTextfield(
                    controller: _pointBController,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: 'AIzaSyBAI-ukTUibokZvU1mbkg-uTWPje2HLj4o',
      request: PolylineRequest(
        origin: PointLatLng(pointA.latitude, pointA.longitude),
        destination: PointLatLng(pointB.latitude, pointB.longitude),
        mode: TravelMode.driving,
      ),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }
}
