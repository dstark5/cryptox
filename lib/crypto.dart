import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class get_cryptoMarket{
  String cur="usd";
  int val=500;
  List<cryptodata> _crypto_data=[];
  get_cryptoMarket(int this.val);

  List<cryptodata> getListData()=> _crypto_data;

   Future<cryptodata?> get() async {
     String stored = await retrivetext("currency");
     if (stored != "null") {
       cur = stored.toLowerCase();
     }
     var data = await http.get(Uri.parse("https://api.coingecko.com/api/v3/coins/markets?vs_currency=$cur&order=market_cap-desc&per_page=$val&page=1"));
     if (data.statusCode == 200) {
       var res = await jsonDecode(data.body);
       for (int x = 0; x < res.length; x++) {
         _crypto_data.add(cryptodata(res[x]));
       }
     }
   }
}

class cryptodata{
  String? id;
  String? name;
  String? price;
  String? icon;
  String? market_cap;
  String? market_pos;
  String? diluted;
  String? volume;
  String? high;
  String? low;
  String? cir_supply;
  String? price_change;
  String? price_change_per;
  String? mcap_chage;
  String? mcap_change_per;
  String? total_supply;
  String? ath;
  String? atl;
  String? ath_date;
  String? atl_date;
  String? max_supply;


  cryptodata(Map datax){
    id=datax["id"];
    name=datax["name"];
    price=datax["current_price"].toString();
    icon=datax["image"];
    market_cap=datax["market_cap"].toString();
    market_pos=datax["market_cap_rank"].toString();
    diluted=datax["fully_diluted_valuation"].toString();
    volume=datax["total_volume"].toString();
    high=datax["high_24h"].toString();
    low=datax["low_24h"].toString();
    cir_supply=datax["circulating_supply"].toString();
    price_change=datax["price_change_24h"].toString();
    price_change_per=datax["price_change_percentage_24h"].toString();
    mcap_chage=datax["market_cap_change_24h"].toString();
    mcap_change_per=datax["market_cap_change_percentage_24h"].toString();
    total_supply=datax["total_supply"].toString();
    ath=datax["ath"].toString();
    atl=datax["atl"].toString();
    ath_date=datax["ath_date"].toString();
    atl_date=datax["atl_date"].toString();
    max_supply=datax["max_supply"].toString();
  }

}

class getdata {
  Future<List> get() async{
    try {
      get_cryptoMarket data = get_cryptoMarket(500);
      await data.get();
      List crypto = await data.getListData();
      return crypto;
    }on SocketException catch(e){
      throw e;
    }catch (e){
      throw e;
    }
  }
}


class trendingdata{
  String? id;
  String? name;
  String? price;
  String? icon;

  trendingdata(Map datax,this.price) {
    id=datax["id"];
    name=datax["name"];
    price=this.price;
    icon=datax["thumb"];
  }

}

class get_trending{

  List<trendingdata> _trending_data=[];
  String cur="usd";
  List<trendingdata> getListData()=> _trending_data;
  Future<trendingdata?> get() async{
    String stored=await retrivetext("currency");
    if(stored!="null"){
      cur=stored.toLowerCase();
    }
      var data = await http.get(Uri.parse("https://api.coingecko.com/api/v3/search/trending"));
      if(data.statusCode==200) {
        var res = await jsonDecode(data.body);
        for (int x = 0; x <7; x++) {
          var json=res["coins"][x]["item"]["id"];
          await Future.delayed(Duration(milliseconds:15));
          var pricedata=await http.get(Uri.parse("https://api.coingecko.com/api/v3/simple/price?ids=$json&vs_currencies=$cur"));
          var z=await jsonDecode(pricedata.body);
          _trending_data.add(trendingdata(res["coins"][x]["item"],z[json][cur].toString()));
        }
      }

  }
}

class gettrenddata{

  Future<List> get() async{
    try {
      await Future.delayed(Duration(milliseconds:50));
      get_trending data = get_trending();
      await data.get();
      List crypto = await data.getListData();
      return crypto;
    }on SocketException catch(e){
      throw e;
    }catch (e){
      throw e;
    }
  }

}

Future<List> Search(String x) async{
    List data = await getdata().get();
    List data_ = [];

    if (x != null) {
      data_.clear();
      for (int z = 0; z < data.length; z++) {
        String z_ = data[z].name;
        if (z_.toLowerCase().contains(x.toLowerCase())) {
          data_.add(data[z]);
        }
      }
    }
    return data_;
  }

class notify extends ChangeNotifier{
  String _searchquery="";
  String get searchquery=>_searchquery;
  void setquery(String x){
    _searchquery=x;
    notifyListeners();
  }
}

class notifier extends ChangeNotifier{
  int _index=1;
  int get index=>_index;
  void setindex(int x){
    _index=x;
    notifyListeners();
  }
}


class get_favourite{
  String cur="usd";
  int val=500;
  List<cryptodata> _crypto_data=[];

  List<cryptodata> getListData()=> _crypto_data;

  Future<cryptodata?> get() async{
    String stored=await retrivetext("currency");
    if(stored!="null"){
      cur=stored.toLowerCase();
    }
    List datalist=await retrivefavourite("favourite");
    var data = await http.get(Uri.parse("https://api.coingecko.com/api/v3/coins/markets?vs_currency=$cur&order=market_cap-desc&per_page=$val&page=1"));
    if(data.statusCode==200) {
      var res = await jsonDecode(data.body);
      for (int x = 0; x <res.length; x++) {
        if(datalist.contains(cryptodata(res[x]).name)){
          _crypto_data.add(cryptodata(res[x]));
        }
      }

    }
  }
}


Future<List> getfavourite() async{
    try {
      await Future.delayed(Duration(milliseconds:50));
      get_favourite data = get_favourite();
      await data.get();
      List crypto = await data.getListData();
      return crypto;
    } on SocketException catch (e) {
      throw e;
    }
    catch (error) {
      throw error;
    }
}

void storetext(String key,x) async {
    SharedPreferences store = await SharedPreferences.getInstance();
    store.setString(key, x);
}

Future<String> retrivetext(String key) async{
  SharedPreferences retrive = await SharedPreferences.getInstance();
  String? retived= retrive.getString(key);
  if(retived!=null){
    return retived;
  }
  else{
    return "null";
  }
}

void storefavourite(String key,String id,[bool rm=false]) async {
  SharedPreferences store = await SharedPreferences.getInstance();
  List<String> data=[];
  List getlist= await retrivefavourite(key);
  for(int x=0;x<getlist.length;x++){
    data.add(getlist[x].toString());
  }
  if(data.contains(id)){
    if(rm==true) {
      data.remove(id);
    }
  }else{
    data.add(id);
  }
  store.setStringList(key,data);
}

Future<List> retrivefavourite(String key) async{
  SharedPreferences retrive = await SharedPreferences.getInstance();
  List<String>? retived=await retrive.getStringList(key);
  if(retived!=null){
    return retived;
  }
  else{
    return <String>[];
  }
}

final provide=FutureProvider<List>(
        (ref)  => getfavourite()
);

final trendingprovider=FutureProvider<List>(
    (ref)async=>await gettrenddata().get()
);

final providechange=ChangeNotifierProvider<notify>((ref)=>notify());



final changex=ChangeNotifierProvider<notifier>((ref)=>notifier());

final provideSearch=FutureProvider.family<List,String>(
        (ref,searchterm) =>  Search(searchterm)
);