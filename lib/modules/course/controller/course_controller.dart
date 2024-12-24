import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:neethusacademy/global/constants/images/images.dart';

class CourseController extends ChangeNotifier {

  List courses = ['OET','IELTS','NCLEX-RN','GERMAN','CBT','OSCE'];
  List courseImages = [oet,ielts,nclex,german,cbt,osce];
   List courseColors = [const Color.fromARGB(255, 232, 224, 149),Colors.green.shade100,Colors.pink.shade100,const Color.fromARGB(255, 162, 174, 239),Colors.purple.shade100,Colors.white];
  List courseUrls = [
    'https://neethusacademy.com/best-oet-coaching-centre-in-kerala/',
   'https://neethusacademy.com/best-ielts-coaching-centre-in-kochi/',
   'https://neethusacademy.com/best-nclex-rn-coaching-centres-in-kerala/',
   'https://neethusacademy.com/best-german-language-institute-in-kerala/',
   'https://neethusacademy.com/cbt-coaching-centre-in-kerala/',
   'https://neethusacademy.com/osce-training-in-kerala/'
];

 double _progress = 0.0;
  String? _selectedUrl;
  InAppWebViewController? _webViewController;

  double get progress => _progress;
  String? get selectedUrl => _selectedUrl;
  InAppWebViewController? get webViewController => _webViewController;

  setProgress(double newProgress) {
    _progress = newProgress;
    notifyListeners();
  }

 setSelectedUrl() {
   _selectedUrl = 'https://esightsolutions.in/neethusapp/demo2/';
    notifyListeners();
  }

 setWebViewController(InAppWebViewController controller) {
    _webViewController = controller;
    notifyListeners();
  }
  
  
}