import 'package:flutter/services.dart';
import 'package:flutter_project/navigate.dart';
import  'package:flutter/material.dart';
import 'package:flutter_project/cryptox.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_project/themes.dart';
import 'package:flutter_project/webview_feed.dart';
import 'package:flutter_project/ad_state.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';
import 'package:flutter_project/about.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await MobileAds.initialize(bannerAdUnitId:adstate().bannerAdUnitId);
  runApp(
      ProviderScope(
        child: material_app(),
      )
  );
}

class material_app extends StatefulWidget {
  @override
  _material_appState createState() => _material_appState();
}

class _material_appState extends State<material_app> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context,watch,child){
      var gettheme=watch(themeprovider);
      var changetheme=context.read(provide_themechange);
      changetheme.addListener(() {
        context.refresh(themeprovider);
      });
     return gettheme.when(
         data:(theme){
        return MaterialApp(
          debugShowCheckedModeBanner:false,
          themeMode:theme,
          title: "CryptoX",
          theme:themes.light_theme,
          darkTheme:themes.dark_theme,
          initialRoute:'/',
          routes:{
            '/':(context) => home(),
            '/cryptox':(context) => cryptox(),
            '/webview' :(context)=>webviewFeed(),
            '/about' :(context)=>about()
          },
        );
      },
         loading: ()=>Center(child:CircularProgressIndicator()),
         error: (e,s){
          return MaterialApp(
             themeMode:ThemeMode.system,
             theme:themes.light_theme,
             darkTheme:themes.dark_theme,
             title:"CryptoX",
             initialRoute:'/',
             routes:{
               '/':(context) => home(),
               '/cryptox':(context) => cryptox(),
               '/webview' :(context)=>webviewFeed(),
               '/about' :(context)=>about()
             },
           );
         });
    });
  }
}
