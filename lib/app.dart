import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project/crypto.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_project/fittext.dart';

class app extends StatefulWidget {
  @override
  _appState createState() => _appState();
}


class _appState extends State<app>{
  int x=0;
  String search="";
  @override
  Widget build(BuildContext context) {
   double width=MediaQuery.of(context).size.width/2.7;
   double price_width=width-65;
    return Container(
      child:Consumer(
        builder:(context,watch,child)
   {
     final data = watch(provideSearch(search));
     var get = context.read(providechange);
     get.addListener(() {
       setState(() {
         search = get.searchquery;
       });
     });

     var getx = watch(changex);
     getx.addListener(() {
       context.refresh(provideSearch(search));
     });

     return data.when(
         data: (snapshot){
           if (snapshot.isNotEmpty) {
             return Container(
                 child: Column(
                   children: [
                     Container(
                       height: 25,
                       color: Theme
                           .of(context)
                           .backgroundColor,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Padding(
                             padding: const EdgeInsets.fromLTRB(
                                 25, 0, 0, 0),
                             child: Text("Crypto", style: TextStyle(
                                 fontWeight: FontWeight.bold)),
                           ),
                           Row(
                             mainAxisAlignment:MainAxisAlignment.center,
                             children: [
                               Padding(
                                 padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                                 child: Text("Change", style: TextStyle(
                                     fontWeight: FontWeight.bold)),
                               ),
                               Padding(
                                 padding: const EdgeInsets.fromLTRB(
                                     0, 0, 25, 0),
                                 child: Text("Price", style: TextStyle(
                                     fontWeight: FontWeight.bold)),
                               ),
                             ],
                           )
                         ],
                       ),
                     ),
                     Flexible(
                       child: RefreshIndicator(
                         color: Theme
                             .of(context)
                             .accentColor,
                         onRefresh: () {
                           return context.refresh(provideSearch(search));
                         },
                         child: Scrollbar(
                           radius:Radius.circular(5.1),
                           child: ListView.builder(
                               keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
                                   .onDrag,
                               itemCount: snapshot.length,
                               itemBuilder: (context, index) {
                                 return Container(
                                   height: 85,
                                   child: GestureDetector(
                                     child: Card(
                                       elevation: 3.0,
                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment
                                             .spaceBetween,
                                         children: [
                                           Row(
                                             children: [
                                               Padding(
                                                 padding: const EdgeInsets
                                                     .all(7.0),
                                                 child: CircleAvatar(
                                                   backgroundImage: CachedNetworkImageProvider(
                                                       snapshot[index].icon),
                                                   backgroundColor: Colors.white,
                                                   radius: 19,),
                                               ),
                                               Padding(
                                                 padding: const EdgeInsets
                                                     .fromLTRB(15, 0, 0, 0),
                                                 child: SizedBox(
                                                   width:width,
                                                   child: fitid(snapshot[index].name
                                                       .toString()),
                                                 ),
                                               )
                                             ],
                                           ),
                                           Builder(builder: (context) {
                                             var x = snapshot[index]
                                                 .price_change_per.toString();
                                             if (x.contains("-")) {
                                               return Container(
                                                 width: width,
                                                 child: Row(
                                                   children: [
                                                     SizedBox(
                                                       height: 35,
                                                       width: 54,
                                                       child: Card(
                                                         child: Row(
                                                           children: [
                                                             Icon(Icons
                                                                 .arrow_downward,
                                                               color: Colors
                                                                   .white,
                                                               size: 15,),
                                                             Builder(builder: (
                                                                 context) {
                                                               if (x.length > 4) {
                                                                 return Text(
                                                                   x.substring(
                                                                       1, 5),
                                                                   style: TextStyle(
                                                                       fontSize: 13,
                                                                       fontWeight: FontWeight
                                                                           .bold,
                                                                       color: Colors
                                                                           .white),);
                                                               } else {
                                                                 return Text(
                                                                   x.substring(
                                                                       1, 4),
                                                                   style: TextStyle(
                                                                       fontSize: 13,
                                                                       fontWeight: FontWeight
                                                                           .bold,
                                                                       color: Colors
                                                                           .white),);
                                                               }
                                                             })
                                                           ],
                                                         ),
                                                         color: Colors.redAccent,
                                                       ),
                                                     ),
                                                     Padding(
                                                       padding: const EdgeInsets
                                                           .all(
                                                           5.0),
                                                       child: SizedBox(
                                                         width:price_width,
                                                         child: FittedBox(
                                                           fit:BoxFit.scaleDown,
                                                           child: fittext(
                                                               snapshot[index].price,
                                                               Colors.red),
                                                         ),
                                                       ),
                                                     )
                                                   ],
                                                 ),
                                               );
                                             } else {
                                               return Container(
                                                 width: width,
                                                 child: Row(
                                                   children: [
                                                     SizedBox(
                                                       height: 35,
                                                       width: 54,
                                                       child: Card(
                                                         child: Row(
                                                           children: [
                                                             Icon(
                                                               Icons.arrow_upward,
                                                               color: Colors
                                                                   .white,
                                                               size: 15,),
                                                             Builder(builder: (
                                                                 context) {
                                                               if (x.length > 3) {
                                                                 return Text(
                                                                   x.substring(
                                                                       0, 4),
                                                                   style: TextStyle(
                                                                       fontSize: 13,
                                                                       fontWeight: FontWeight
                                                                           .bold,
                                                                       color: Colors
                                                                           .white),);
                                                               } else {
                                                                 return Text(
                                                                   x.substring(
                                                                       0, 3),
                                                                   style: TextStyle(
                                                                       fontSize: 13,
                                                                       fontWeight: FontWeight
                                                                           .bold,
                                                                       color: Colors
                                                                           .white),);
                                                               }
                                                             })
                                                           ],
                                                         ),
                                                         color: Colors.greenAccent
                                                             .shade700,
                                                       ),
                                                     ),
                                                     Padding(
                                                       padding: const EdgeInsets
                                                           .all(
                                                           5.0),
                                                       child: SizedBox(
                                                         width:price_width,
                                                         child: FittedBox(
                                                           fit:BoxFit.scaleDown,
                                                           child: fittext(
                                                               snapshot[index].price
                                                                   .toString(),
                                                               Colors.green),
                                                         ),
                                                       ),
                                                     ),

                                                   ],
                                                 ),
                                               );
                                             }
                                           }),
                                         ],
                                       ),
                                     ),
                                     onTap: () {
                                       Navigator.pushNamed(
                                           context, '/cryptox', arguments: [
                                         snapshot[index].name,
                                         snapshot[index].icon,
                                         snapshot[index].price,
                                         snapshot[index].market_cap,
                                         snapshot[index].market_pos,
                                         snapshot[index].diluted,
                                         snapshot[index].volume,
                                         snapshot[index].high,
                                         snapshot[index].low,
                                         snapshot[index].cir_supply,
                                         snapshot[index].price_change,
                                         snapshot[index].price_change_per,
                                         snapshot[index].mcap_chage,
                                         snapshot[index].mcap_change_per,
                                         snapshot[index].total_supply,
                                         snapshot[index].ath,
                                         snapshot[index].atl,
                                         snapshot[index].ath_date.toString().substring(0,10),
                                         snapshot[index].atl_date.toString().substring(0,10),
                                         snapshot[index].max_supply
                                       ]);
                                     },
                                     onLongPress: () async {
                                       storefavourite(
                                           "favourite", snapshot[index].name);
                                       ScaffoldMessenger.of(context).showSnackBar(
                                           SnackBar(content: Text(
                                               "Added to favourite"),
                                               duration: Duration(seconds: 1)));
                                       await Future.delayed(
                                           Duration(milliseconds: 50));
                                       context.refresh(provide);
                                     },
                                   ),
                                 );
                               }
                           ),
                         ),
                       ),
                     ),
                   ],
                 )
             );
           }else{
             return Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Container(
                     width: width * 2,
                     child: Image.asset("images/data.png")),
                 SizedBox(height: 25),
                 Center(
                   child: Text("No data found!", style: TextStyle(
                       fontWeight: FontWeight.bold, fontSize: 19),),
                 ),
               ],
             );
           }
         },
         loading: () =>
             Center(child: CircularProgressIndicator(color: Colors.blueAccent)),
         error: (e, s) {
            return Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Flexible(
                   child: Container(
                     child: Image.asset("images/internet.png"),
                   ),
                 ),
                 SizedBox(height:25),
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
                           context.refresh(provideSearch(""));
                           context.refresh(provide);
                           context.refresh(trendingprovider);
                         },

                       ),
                     ),
                   ),
                 )
               ],
             );
         });
        },
      ),
      );
  }
}



