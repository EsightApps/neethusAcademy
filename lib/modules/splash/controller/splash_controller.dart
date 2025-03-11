import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import '../../course/service/course_service.dart';


class SplashController extends ChangeNotifier {
  String webLink = '';
  getWebLink() async {
    final response = await CourseService().getWebApi();
    if (response.statusCode == 200) {
       webLink = json.decode(response.body)['website_link'];
        log('Website link: $webLink');
  
    } else {}
    notifyListeners();
  }
}
