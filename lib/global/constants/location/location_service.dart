import 'dart:developer';

import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<void> checkLocationServiceAndPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log("Location permission denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      log("Location permissions are permanently denied. Cannot request.");
      return;
    }

    // Permissions are granted; fetch the location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    log("Location: ${position.latitude}, ${position.longitude}");
  }
}
