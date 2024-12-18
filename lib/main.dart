import 'dart:io';
import 'package:neethusacademy/global/config/databox.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neethusacademy/global/constants/provider/providers.dart';
import 'package:provider/provider.dart';
import 'global/config/config.dart';
import 'global/constants/routes/routes.dart';
import 'global/constants/styles/colors.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // //*-- Firebase Notifications
  // if (Platform.isAndroid) {
  //   await PushNotificationService().initialize();
  // }
   OneSignal.initialize(
    "3cf177ca-aefc-4b09-bb2b-c4ecb039c6f8",  
  );
  
   
    OneSignal.Notifications.requestPermission(true);

   OneSignal.Notifications.addForegroundWillDisplayListener((OSNotificationWillDisplayEvent event){
        print("Notification received in foreground: ${event.notification.body}");
      event.notification;
   });



 


   


  //*--
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
 userSavedBox =  await Hive.openBox<String>(Config.dbName);
  runApp( MultiProvider(providers: providerList,
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
   
  return Platform.isIOS
        ? ScreenUtilInit(
            designSize: const Size(333, 675),
            child: CupertinoApp(
                title: "Neethu's Academy",
                routes:  routes,
                initialRoute: '/',
                theme: const CupertinoThemeData(
                    barBackgroundColor: kWhite,
                    primaryColor: kBlack),
                debugShowCheckedModeBanner: false,
                localizationsDelegates: const [
                  DefaultWidgetsLocalizations.delegate,
                  DefaultMaterialLocalizations.delegate,
                  DefaultCupertinoLocalizations.delegate
                ]),
          )
        : ScreenUtilInit(
            designSize: const Size(333, 675),
            child: MaterialApp(
                routes: routes,
               title: "Neethu's Academy",
                initialRoute: '/',
                debugShowCheckedModeBanner: false,
                theme: ThemeData.light().copyWith(
                  searchBarTheme: const SearchBarThemeData(
                      backgroundColor:
                         WidgetStatePropertyAll(kWhite)),
                )));
  }
}


