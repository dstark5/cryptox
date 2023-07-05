import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_project/themes.dart';

class drawer extends StatefulWidget {
  @override
  __drawerState createState() => __drawerState();
}

class __drawerState extends State<drawer> {
  @override
  int index=0;
  List currency=["USD","EUR","INR","CNY","AED","AUD","GBP","IDR","RUB","JPY","KRW","TWD","ARS","BDT","BHD","BMD","BRL","CHF","CLP","CZK","DKK","HKD","HUF","ILS","KWD","LKR","MMK","MXN","MYR","NGN","NOK","NZD","PHP","PKR","PLN","SAR","SEK","SGD","THB","TRY","UAH","VEF","VND","ZAR","XDR","XAG","XAU"];
  String Mode="Dark Mode";
  IconData modeicon=Icons.dark_mode;

  __drawerState(){
    retrivedata();
    gettheme();
  }

  Widget build(BuildContext context) {
    var themechanger=context.read(provide_themechange);
    var get=context.read(changex);
    return Drawer(
      child:ListView(
        shrinkWrap: true,
        children: [
          Container(
            height:54,
            // color:Colors.blueAccent,
            decoration:BoxDecoration(
              gradient: LinearGradient(colors: [Colors.blue,Colors.deepPurple,Colors.red]),
            ),
            child: Center(child: Text("Crypto X",style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize:21),)),
          ),
      InkWell(
        splashColor:Colors.red,
        child:Container(height:54,
            child: Row(
              children: [
                SizedBox(width: 5),
                Icon(modeicon,color:Colors.redAccent),
                SizedBox(width:15),
                Text(Mode,style:TextStyle(fontWeight: FontWeight.bold,fontSize:19)),
              ],
            )
        ),
        onTap: (){
            setState(() {
              if(Mode=="Dark Mode") {
                Mode = "Light Mode";
                modeicon = Icons.brightness_5;
                themechanger.themechange(false);
              }else{
                Mode="Dark Mode";
                modeicon=Icons.dark_mode;
                themechanger.themechange(true);
              }
            });
        },
      ),
          Container(
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 5),
                    Icon(Icons.monetization_on_outlined,color:Colors.redAccent),
                    SizedBox(width: 15),
                    Text("Currency",style:TextStyle(fontWeight: FontWeight.bold,fontSize:19)),
                  ],
                ),
                DropdownButton(
                  value:index,
                  items:[for(int z=0;z<currency.length;z++)DropdownMenuItem(child:Text(currency[z]),value: z)],
                  onChanged:(int? z) async{
                    setState((){
                      index=z!;
                      storetext("currency",currency[index]);
                      storetext("index", index.toString());
                      retrivedata();
                      Future.delayed(Duration(seconds:1));
                      get.setindex(index);
                    });
                  },
                ),
              ],
            ),
          ),
      InkWell(
        splashColor:Colors.red,
        child:Container(height:54,
        child: Row(
        children: [
        SizedBox(width: 5),
        Icon(Icons.info,color:Colors.redAccent),
        SizedBox(width:15),
          Text("About",style:TextStyle(fontWeight: FontWeight.bold,fontSize:19)),
          ],
        )
      ),
    onTap: (){
      Navigator.pushNamed(context,"/about");
    },
    )
        ],
      ),
    );
  }
  void retrivedata() async{
    String stored=await retrivetext("index");
    if(stored!="null") {
      int z=int.parse(stored);
      setState(() {
        index=z;
      });
    }
  }

  void gettheme() async{
     ThemeMode data=await get_theme();
     if(data==ThemeMode.dark){
       setState(() {
         Mode = "Light Mode";
         modeicon = Icons.brightness_5;
       });
     }
  }
}

