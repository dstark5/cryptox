import 'package:flutter/material.dart';
import 'package:flutter_project/ad_state.dart';
import 'package:flutter_project/themes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_project/data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class feed extends StatefulWidget {
  const feed({Key? key}) : super(key: key);
  @override
  _feedState createState() => _feedState();
}

class _feedState extends State<feed> {
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double title_width=width-width/4;

    CacheManager cache=CacheManager(
      Config(
        "cacheImage_api",
        stalePeriod:const Duration(days:1),
      ),
    );

    return Container(
      child:Consumer(builder:(context,watch,child){
        final getdata=watch(providerx);
        var themechanged=context.read(provide_themechange);

        themechanged.addListener(() {
          context.refresh(providerx);
        });

       return getdata.when(data:(data){
         List datax=data;
         if(datax.isNotEmpty && datax!=null) {
           final dataLen = datax.length;
           for (int x = 4; x <= dataLen; x += 5) {
             datax.insert(x, "ads");
           }
           return RefreshIndicator(
             color: Theme
                 .of(context)
                 .accentColor,
             onRefresh: () {
               return context.refresh(providerx);
             },
             child: Scrollbar(
               radius: Radius.circular(5.1),
               child: ListView.builder(
                   itemCount: datax.length,
                   itemBuilder: (context, index) {
                     if (datax[index] == "ads") {
                       return BannerAd(
                         size: BannerSize.ADAPTIVE,
                         controller: adController().adListener,
                         loading: Padding(
                           padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                           child: Text("ad"),
                         ),
                         error: Padding(
                           padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                           child: Text("ad"),
                         ),
                         builder: (context, child) {
                           return Card(
                             child: child,
                           );
                         },
                       );
                     } else {
                       return GestureDetector(
                         child: Container(
                           height: 150,
                           child: Card(
                             child: Row(
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.all(5.0),
                                   child: CachedNetworkImage(
                                       imageUrl: datax[index].image,
                                       width: width / 5,
                                       cacheManager: cache,
                                       placeholder: (context, url) =>
                                           Container(color: Colors.grey),
                                       errorWidget: (context, url, error) =>
                                           Icon(Icons.error_outline)),
                                 ),
                                 Container(
                                     width: title_width,
                                     child: Padding(
                                       padding: const EdgeInsets.fromLTRB(
                                           10, 0, 0, 0),
                                       child: Column(
                                         mainAxisAlignment: MainAxisAlignment
                                             .spaceEvenly,
                                         children: [
                                           Text(datax[index].title,
                                               style: TextStyle(
                                                   fontWeight: FontWeight.bold,
                                                   fontSize: 15), maxLines: 3),
                                           Padding(
                                             padding: const EdgeInsets.fromLTRB(
                                                 10, 0, 0, 0),
                                             child: SizedBox(
                                               width: title_width,
                                               child: FittedBox(
                                                 fit:BoxFit.scaleDown,
                                                 child: Row(
                                                   children: [
                                                     Text("source: "),
                                                     Text(datax[index].src,
                                                       style: TextStyle(
                                                           color: Colors
                                                               .blueAccent,
                                                           fontWeight: FontWeight
                                                               .bold),
                                                       overflow: TextOverflow
                                                           .clip,),
                                                   ],
                                                 ),
                                               ),
                                             ),
                                           )
                                         ],
                                       ),
                                     ))
                               ],
                             ),
                           ),
                         ),
                         onTap: () {
                           Navigator.pushNamed(
                             context, '/webview', arguments: datax[index].link,
                           );
                         },
                       );
                     }
                   }),
             ),
           );
         }else{
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
                           context.refresh(providerx);
                         },

                       ),
                     )
                 ),
               )
             ],
           );
         }
        },
            loading:() =>
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
                           context.refresh(providerx);
                         },
                       ),
                     ),
                   ),
                 )
               ],
             );
           });
      })
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    adController().disposeAdController();
  }
}
