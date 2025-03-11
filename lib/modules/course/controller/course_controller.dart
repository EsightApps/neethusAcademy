import 'dart:developer';

import 'package:NeethusApp/modules/course/service/course_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class CourseController extends ChangeNotifier {
  String location = '';
  checkLocationServiceAndPermission() async {
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
    notifyListeners();
    
    location = "latitude:${position.latitude}, longitude:${position.longitude}";
     notifyListeners();
    log("Location: ${position.latitude}, ${position.longitude}");
  }

  addCourse(String userId, String name, String location) async {
    final response = await CourseService().addCourseApi(
        {'user_id': userId, 'course_name': name, 'location': location});
    if (response.statusCode == 200) {
      log(response.body);
    } else {}
    notifyListeners();
  }
}
