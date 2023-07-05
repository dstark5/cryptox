import 'package:flutter/material.dart';
import 'package:flutter_project/app.dart';
import 'package:flutter_project/favourite.dart';
import 'package:flutter_project/trending.dart';
import 'package:flutter_project/drawer.dart';
import 'package:flutter_project/crypto.dart';
import 'package:flutter_project/crypto_feed.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  List<Widget> screen=[app(),favourite(),trending(),feed()];
  int x=0;
  Widget apptitle=Text("CryptoX",style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize:21));
  Icon action=Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    var get=context.read(providechange);

    return Scaffold(
      appBar:AppBar(
        title:apptitle,
        iconTheme:IconThemeData(color:Colors.white),
        actions: [
          IconButton(icon:action,onPressed:(){
            if(action.icon==Icons.close){
              get.setquery("");
            }
              setState(() {
            if(action.icon==Icons.search){
              x=0;
              apptitle=TextField(
                autofocus:true,
                style:TextStyle(color:Colors.white),
                cursorColor: Colors.white,
                decoration:InputDecoration(
                    prefixIcon:Icon(Icons.search,color:Colors.white,),
                    hintText:"Search",
               hintStyle:TextStyle(color:Colors.white),
               focusedBorder: UnderlineInputBorder(borderSide:BorderSide(color:Colors.white)),
               enabledBorder:UnderlineInputBorder(borderSide:BorderSide(color:Colors.white))),
                onChanged:(String x){
                    get.setquery(x);
                },
              );
              action=Icon(Icons.close);
            }else{
              apptitle=Text("CryptoX",style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize:21));
              action=Icon(Icons.search);
            }
          });
          }
        )
        ],
      ),
      drawer:drawer(),
      bottomNavigationBar:BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon:Icon(Icons.home,size:21),label:"Home"),
          BottomNavigationBarItem(icon:Icon(Icons.favorite,size:21),label:"Favourite"),
          BottomNavigationBarItem(icon:Icon(Icons.trending_up,size:21),label:'Trending'),
          BottomNavigationBarItem(icon:Icon(Icons.feed,size:21),label:'Feed')
        ],
        currentIndex:x,
        // backgroundColor:Colors.white,
        selectedItemColor:Theme.of(context).highlightColor,
        unselectedItemColor:Colors.blueGrey,
        onTap:(int z) {
          setState(() {
            x = z;
          });
        } ,
      ),
      body:IndexedStack(
        index:x,
        children:screen,
      ),
    );
  }
}

