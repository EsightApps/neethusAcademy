import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../course/controller/course_controller.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CourseController>(
      builder: (context, courseCtrl, _) {
        return Scaffold(
          body: Column(
            children: [
              // Place LinearProgressIndicator at the top
              courseCtrl.progress < 1
                  ? LinearProgressIndicator(value: courseCtrl.progress)
                  : const SizedBox.shrink(),

              // WebView below the progress indicator
              if (courseCtrl.selectedUrl != null)
                Expanded(
                  child: InAppWebView(
                    onProgressChanged:
                        (inAppWebViewController, int progress) {
                      courseCtrl.setProgress(progress / 100.0);
                    },
                    onWebViewCreated: (inAppWebViewController) {
                      courseCtrl.setWebViewController(inAppWebViewController);
                    },
                    initialUrlRequest: URLRequest(
                      url: WebUri.uri(Uri.parse(courseCtrl.selectedUrl.toString())),
                    ),
                    shouldOverrideUrlLoading:
                        (inAppWebViewController, navigationAction) async {
                      var url = navigationAction.request.url.toString();

                      // Check if the URL is a phone number or WhatsApp link
                      if (url.startsWith("tel:")) {
                        // Handle phone number link
                        await launchUrl(Uri.parse(url)); // Opens the dialer
                        return NavigationActionPolicy.CANCEL;
                      } else if (url.startsWith("whatsapp://")) {
                        // Handle WhatsApp link
                        await launchUrl(Uri.parse(url)); // Opens WhatsApp
                        return NavigationActionPolicy.CANCEL;
                      } 
                      return NavigationActionPolicy.ALLOW; // Allow other links to load
                    },
                    onLoadError: (inAppWebViewController, url, code, message) {
                     log("Error loading page: $message");
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
