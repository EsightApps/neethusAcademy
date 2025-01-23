
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neethusacademy/global/constants/styles/colors.dart';
import 'package:neethusacademy/modules/splash/controller/splash_controller.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../course/widget/alertbox.widget.dart';

class HomeScreen extends StatefulWidget {
  final String url;
  const HomeScreen({super.key, required this.url});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late InAppWebViewController webViewController;
  double progress = 0.0;
  late String homeUrl;  
  final String mockTestUrl = "https://mocktestportal.neethusacademy.com/";

  @override
  void initState() {
    super.initState();
    var splashCtrl = Provider.of<SplashController>(context, listen: false);
  
    
    homeUrl = splashCtrl.webLink;
  }

  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: () async {
        // Get the current URL from the WebView
        var currentUrl = await webViewController.getUrl();
        if (currentUrl?.toString() == mockTestUrl) {
          // If on the Mock Test URL, navigate to the home URL
          await webViewController.loadUrl(urlRequest: URLRequest(url: WebUri(homeUrl)));
          return false; // Prevent the app from exiting
        } else if (currentUrl?.toString() == homeUrl) {
          // If on the Home URL, show exit confirmation dialog
          bool exitApp = await showDialog(
            context: context,
            builder: (context) {
              return AlertBoxWidget(
                title: 'Exit App?',
                content: 'Are you sure you want to exit the application?',
                subtitle: 'Exit',
                onPressed: () {
                  Navigator.of(context).pop(true);
                  
                },
              );
            },
          );
          if (exitApp == true) {
            SystemNavigator.pop(); 
          }
          return false;
        } else {
        
          await webViewController.goBack();
          return false;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kBlue,
        body: SafeArea(
          child: Stack(
            children: [
              // WebView
              InAppWebView(
                initialUrlRequest: URLRequest(
                  url: WebUri(widget.url),
                ),
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                onProgressChanged: (controller, int progressValue) {
                  setState(() {
                    progress = progressValue / 100.0;
                  });
                },
                onLoadStop: (controller, url) async {
                  // Clear WebView history when loading the home URL
                  if (url?.toString() == homeUrl) {
                    await webViewController.clearHistory();
                  }
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  var url = navigationAction.request.url.toString();

                  // Handle YouTube links
                  if (url.contains("youtube.com") || url.contains("youtu.be")) {
                    if (await canLaunch(url)) {
                      await launchUrl(
                        Uri.parse(url),
                        mode: LaunchMode.externalApplication,
                      );
                    }
                    return NavigationActionPolicy.CANCEL;
                  }

                  // Handle Facebook redirects and intent URLs
                  if (url.startsWith("intent://")) {
                    try {
                      var fallbackUrl = Uri.decodeFull(
                        url.split('S.browser_fallback_url=')[1].split(';end')[0],
                      );
                      if (await canLaunch(fallbackUrl)) {
                        await launchUrl(
                          Uri.parse(fallbackUrl),
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    } catch (e) {
                      print("Failed to handle intent:// URL: $e");
                    }
                    return NavigationActionPolicy.CANCEL;
                  }

                  if (url.contains("facebook.com") || url.contains("fb.me")) {
                    if (await canLaunch(url)) {
                      await launchUrl(
                        Uri.parse(url),
                        mode: LaunchMode.externalApplication,
                      );
                    }
                    return NavigationActionPolicy.CANCEL;
                  }

                  // Handle mail and phone links
                  if (url.startsWith("tel:") || url.startsWith("mailto:")) {
                    if (await canLaunch(url)) {
                      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                    }
                    return NavigationActionPolicy.CANCEL;
                  }

                  return NavigationActionPolicy.ALLOW;
                },
              ),

              // Circular Progress Indicator
              if (progress > 0 && progress < 1)
                Center(
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 4.w,
                    color: kBlue,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
