import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_project/crypto.dart';

class themes{
  static final dark_theme=ThemeData(
    scaffoldBackgroundColor:Colors.black,
    primaryColor:Colors.blueAccent,
    colorScheme:ColorScheme.dark(),
    accentColor:Colors.blueAccent,
    backgroundColor:Colors.black,
    highlightColor:Colors.tealAccent,
  );

  static final light_theme=ThemeData(
    scaffoldBackgroundColor:Colors.white,
    primaryColor:Colors.blueAccent,
    colorScheme:ColorScheme.light(),
    accentColor:Colors.blueAccent,
    backgroundColor: Colors.white,
    highlightColor:Colors.blueAccent,
  );

}


Future get_theme() async{
    String islight= await retrivetext("islight");

    if(islight=="true"){
      return ThemeMode.light;
    }if(islight=="false"){
      return ThemeMode.dark;
    }else{
      return ThemeMode.light;
    }
}

void Store_theme(islight){
    storetext("islight", islight);
}

class change_theme extends ChangeNotifier{
  bool? islight;
  themechange(bool x){
    islight=x;
    if(x){
      Store_theme("true");
    }else{
      Store_theme("false");
    }
    notifyListeners();
  }
}

final provide_themechange=ChangeNotifierProvider((ref)=>change_theme());
final themeprovider=FutureProvider((ref)=>get_theme());