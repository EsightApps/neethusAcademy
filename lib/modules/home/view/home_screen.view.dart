import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../global/constants/styles/colors.dart';
import '../../course/widget/alertbox.widget.dart';
import '../../splash/controller/splash_controller.dart';

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
  bool isHomeLoading = false;

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
        var currentUrl = await webViewController.getUrl();
        if (currentUrl?.toString() == mockTestUrl) {
          await webViewController.loadUrl(
              urlRequest: URLRequest(url: WebUri(homeUrl)));
          return false;
        } else if (currentUrl?.toString() == homeUrl) {
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
              InAppWebView(
                initialSettings: InAppWebViewSettings(forceDark: ForceDark.OFF),
                initialUrlRequest: URLRequest(
                  url: WebUri(widget.url),
                ),
               onWebViewCreated: (controller) {
 
    webViewController = controller;
  
},

                onProgressChanged: (controller, int progressValue) {
                  if (mounted) {
                    setState(() {
                      progress = progressValue / 100.0;
                    });
                  }
                },
                onLoadStart: (controller, url) {
                  if (url?.toString() == homeUrl) {
                    setState(() {
                      isHomeLoading = true;
                    });
                  }
                },
                onLoadStop: (controller, url) async {
                  if (url?.toString() == homeUrl) {
                    // Clear history only for Android
                    if (Platform.isAndroid) {
                      await webViewController.clearHistory();
                    }
                    setState(() {
                      isHomeLoading = false;
                    });
                  }
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  var url = navigationAction.request.url.toString();
                  if (url.contains("instagram.com") ||
                      url.contains("youtube.com") ||
                      url.contains("youtu.be") ||
                      url.contains("facebook.com") ||
                      url.contains("fb.me")) {
                    if (await canLaunch(url)) {
                      await launchUrl(Uri.parse(url),
                          mode: LaunchMode.externalApplication);
                    }
                    return NavigationActionPolicy.CANCEL;
                  }
                  if (url.startsWith("intent://")) {
                    try {
                      var fallbackUrl = Uri.decodeFull(
                        url
                            .split('S.browser_fallback_url=')[1]
                            .split(';end')[0],
                      );
                      if (await canLaunch(fallbackUrl)) {
                        await launchUrl(Uri.parse(fallbackUrl),
                            mode: LaunchMode.externalApplication);
                      }
                    } catch (e) {
                      print("Failed to handle intent:// URL: $e");
                    }
                    return NavigationActionPolicy.CANCEL;
                  }
                  if (url.startsWith("mailto:")) {
                    try {
                      final emailUri = Uri.parse(url);
                      if (await canLaunchUrl(emailUri)) {
                        await launchUrl(emailUri,
                            mode: LaunchMode.externalApplication);
                      } else {
                        String email = emailUri.path;
                        String? subject = emailUri.queryParameters['subject'];
                        String? body = emailUri.queryParameters['body'];
                        String gmailUrl = Uri.encodeFull(
                          "https://mail.google.com/mail/?view=cm&fs=1&to=$email"
                          "${subject != null ? '&su=$subject' : ''}"
                          "${body != null ? '&body=$body' : ''}",
                        );
                        if (await canLaunchUrl(Uri.parse(gmailUrl))) {
                          await launchUrl(Uri.parse(gmailUrl),
                              mode: LaunchMode.externalApplication);
                        } else {
                          throw "No email app available.";
                        }
                      }
                    } catch (e) {
                      print("Error handling mailto link: $e");
                      Fluttertoast.showToast(
                        msg: "No email app available to handle this link.",
                        backgroundColor: kBlack,
                      );
                    }
                    return NavigationActionPolicy.CANCEL;
                  }
                  if (url.startsWith("tel:")) {
                    if (await canLaunch(url)) {
                      await launchUrl(Uri.parse(url),
                          mode: LaunchMode.externalApplication);
                    }
                    return NavigationActionPolicy.CANCEL;
                  }
                  return NavigationActionPolicy.ALLOW;
                },
              ),
              if (isHomeLoading)
                Center(
                  child: CircularProgressIndicator(
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
