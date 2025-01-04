import 'dart:developer';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
Future<void> requestLocationAndFetchDetails() async {
  // Step 1: Request location permission
  PermissionStatus permissionStatus = await Permission.location.request();

  // Step 2: Check if permission is granted
  if (permissionStatus.isGranted) {
    // Permission granted, get the location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  log("Latitude: ${position.latitude}, Longitude: ${position.longitude}");
    
    // Use the position object as needed
    // For example, return position or store it in a variable
  } else if (permissionStatus.isDenied || permissionStatus.isPermanentlyDenied) {
    log("Location permission denied. Cannot fetch location.");
    // Handle the case where permission is denied (show a dialog, etc.)
  }
}
}