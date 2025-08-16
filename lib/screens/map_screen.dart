import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../core/app_router.dart';
import '../data/mock_data.dart';
import '../models/branch.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // ignore: unused_field
  GoogleMapController? _controller;

  @override
  Widget build(BuildContext context) {
    final markers = mockBranches.map((b) => _toMarker(b, context)).toSet();
    final first = mockBranches.first;
    final camera = CameraPosition(
      target: LatLng(first.lat, first.lng),
      zoom: 10,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Map View')),
      body: GoogleMap(
        initialCameraPosition: camera,
        markers: markers,
        onMapCreated: (c) => _controller = c,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
      ),
    );
  }

  Marker _toMarker(Branch b, BuildContext context) => Marker(
    markerId: MarkerId(b.id),
    position: LatLng(b.lat, b.lng),
    infoWindow: InfoWindow(
      title: b.name,
      snippet: '${b.city} • ₹${b.pricePerHour.toStringAsFixed(0)}/hr',
      onTap: () => Navigator.pushNamed(context, AppRouter.detail, arguments: b),
    ),
  );
}
