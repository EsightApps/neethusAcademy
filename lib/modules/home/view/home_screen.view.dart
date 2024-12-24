
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:neethusacademy/global/constants/styles/colors.dart';
import 'package:url_launcher/url_launcher.dart';


class HomeScreen extends StatefulWidget {
  final String url;
  const HomeScreen({super.key, required this.url});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late InAppWebViewController webViewController;
  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Ensure back navigation works correctly in the WebView
        if (await webViewController.canGoBack()) {
          // Go back in the WebView history
          await webViewController.goBack();
          return false; // Prevent the default back button action (closing the app)
        }
        return true; // Allow the default back button action (close the app)
      },
      child: Scaffold(
        backgroundColor: kBlue, // Avoid duplicate background stacking
        body: SafeArea(
          child: Column(
            children: [
              if (progress < 1) LinearProgressIndicator(value: progress),
              Expanded(
                child: InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: WebUri(widget.url),
                  ),
                  onWebViewCreated: (controller) {
                    webViewController = controller;
                  },
                  onProgressChanged: (controller, int progressValue) {
                    // Update progress state for the linear indicator
                    setState(() {
                      progress = progressValue / 100.0;
                    });
                  },
                  shouldOverrideUrlLoading: (controller, navigationAction) async {
                    // Handle special URL schemes like tel: and mailto:
                    var url = navigationAction.request.url.toString();
                    if (url.startsWith("tel:") || url.startsWith("mailto:")) {
                      await launchUrl(Uri.parse(url));
                      return NavigationActionPolicy.CANCEL;
                    }
                    // Check if the URL is one of the course-specific links
                    // Here you can adjust based on the URL or deep link condition that was causing the course screen transition.
                    if (url.contains("course")) {
                      // Handle course link navigation here if needed (for instance, show a different screen or route)
                      return NavigationActionPolicy.CANCEL; // Prevent unwanted navigation
                    }
                    return NavigationActionPolicy.ALLOW;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
