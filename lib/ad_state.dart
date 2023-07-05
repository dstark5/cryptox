import 'package:native_admob_flutter/native_admob_flutter.dart';

class adstate{
  String get bannerAdUnitId=>"Paste Google Ads key here";
}

class adController{
  final adListener=BannerAdController();
    adController() {
      adListener.onEvent.listen((event) {
        if(event.keys.first==BannerAdEvent.loading){
          print("loading");
        }
        if(event.keys.first==BannerAdEvent.loaded){
          print("loaded");
        }
        if(event.keys.first==BannerAdEvent.loadFailed){
          print("load failed");
          adListener.load();
        }
        if(event.keys.first==BannerAdEvent.impression){
          print("impression");
        }
    });
  }
  disposeAdController(){
    adListener.dispose();
  }

}