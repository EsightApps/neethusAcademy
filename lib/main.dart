import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'global/config/config.dart';
import 'global/config/databox.dart';
import 'global/constants/provider/providers.dart';
import 'global/constants/routes/routes.dart';
import 'global/constants/styles/colors.dart';



void main()async {
  WidgetsFlutterBinding.ensureInitialized();
 
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
                title: "Neethu's App",
                routes:  routes,
                initialRoute: '/',
                theme: const CupertinoThemeData(
                    barBackgroundColor: kWhite,
                    primaryColor: kWhite,),
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
               title: "Neethu's App",
                initialRoute: '/',
                debugShowCheckedModeBanner: false,
                darkTheme: ThemeData.light(),
                theme: ThemeData(),
                themeMode: ThemeMode.system,
                
               ));
  }
}


