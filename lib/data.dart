import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


Future data() async{
  List cryptodata=[];
  try{
  var data = await http.get(Uri.parse("http://cryptonewsapi.herokuapp.com"));
  if(data.statusCode==200) {
    var res = await jsonDecode(data.body);
    for (int x = 0; x < res.length; x++) {
      if (res[x]["image"] != false) {
        cryptodata.add(datax(res[x]));
      }
    }
    return cryptodata;
  }
  }on SocketException catch(e){
    throw e;
  }catch (e){
    throw e;
  }
}



class datax{
  String? title;
  String? link;
  String? image;
  String? src;
  datax(data) {
    title= data["title"];
    link=data["link"];
    image=data["image"];
    src=data["source"];
  }
}

var providerx=FutureProvider((ref)=>data());