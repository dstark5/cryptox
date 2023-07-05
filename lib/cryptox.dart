import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class cryptox extends StatefulWidget {
  const cryptox({Key? key}) : super(key: key);

  @override
  _cryptoxState createState() => _cryptoxState();
}

class _cryptoxState extends State<cryptox> {
  @override
  Widget build(BuildContext context) {
    List data_=ModalRoute.of(context)!.settings.arguments as List;
    double width=MediaQuery.of(context).size.width/2.3;
    List title=["Price","Market_cap","Market_Position","Volume_diluted","Volume",
      "High_24h","Low_24h","Circulated_supply","Price_change 24h","Price_change % ",
      "Market_cap_change 24h","Market_cap_change 24h % ","Total_supply","ath","atl","ath_date","atl_date","Max_supply"];
    return Scaffold(
      appBar:AppBar(
        title:Text("CryptoX",style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize:21)),
        iconTheme:IconThemeData(color:Colors.white),
      ),
      body:Builder(
        builder:(context){
          if (data_.isNotEmpty){
            return Container(
              color:Theme.of(context).backgroundColor,
              child:Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                      children: [
                        CircleAvatar(backgroundImage:CachedNetworkImageProvider(data_[1]),radius: 35,backgroundColor: Colors.white,),
                        SizedBox(height:15),
                        Center(child: Text(data_[0],style:TextStyle(fontSize:21,fontWeight: FontWeight.bold))),
                        SizedBox(height:15,),
                        for(int index=0;index<title.length;index++) Container(
                            height:54,
                           child: Row(
                           children: [
                            SizedBox(width: width,child: Text(title[index],style:TextStyle(fontSize:15,fontWeight: FontWeight.bold,color:Colors.blueGrey))),
                            SizedBox(width:10),
                             SizedBox(width: width,child: Text(data_[index+2],style:TextStyle(fontSize:15,fontWeight: FontWeight.bold)))])
                        )
                      ],
            ),
                ),
              ),
          );
          }
          else{
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                      width:width*2,
                      child:Image.asset("images/refresh.png")),
                ),
                SizedBox(height: 35),
                Center(
                  child: Container(
                      child:ConstrainedBox(
                        constraints:BoxConstraints.tightFor(width:190.0,height:54.0),
                        child: ElevatedButton(
                          style:ButtonStyle(
                              backgroundColor:MaterialStateProperty.all(Theme.of(context).accentColor),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(borderRadius:BorderRadius.circular(25.0))
                              )
                          ),
                          child: Text("Refresh",style:TextStyle(fontWeight:FontWeight.bold,fontSize:19),),
                          onPressed:() {
                            Navigator.pop(context);
                          },

                        ),
                      )
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
