import 'package:flutter/material.dart';
import 'package:flutter_project/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_project/fittext.dart';

class trending extends StatefulWidget {
  const trending({Key? key}) : super(key: key);

  @override
  _trendingState createState() => _trendingState();
}

class _trendingState extends State<trending> {
  @override
  Future<List> data=gettrenddata().get();

  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width/2.7;
    return Container(
      child:Consumer(
        builder:(context,watch,child){
          final data =watch(trendingprovider);
          var getx=watch(changex);
          getx.addListener(() {
            context.refresh(trendingprovider);
          });

          return data.when(
              data:(snapshot){
                if(snapshot.isNotEmpty) {
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
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 0, 15, 0),
                                  child: Text("Price", style: TextStyle(
                                      fontWeight: FontWeight.bold)),
                                )
                              ],
                            ),
                          ),
                          Flexible(
                            child: ListView.builder(
                                itemCount: snapshot.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 85,
                                    child: Card(
                                      elevation: 3.0,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                    7.0),
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
                                                  width: width*1.3,
                                                  child: Text(
                                                      snapshot[index].name,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          fontSize: 15),
                                                      overflow: TextOverflow
                                                          .clip),
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: fit(snapshot[index].price),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            ),
                          ),
                        ],
                      )
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
                                  context.refresh(trendingprovider);
                                },
                              ),
                            )
                        ),
                      )
                    ],
                  );
                }
              },
              loading:()=> Center(child: CircularProgressIndicator(color:Theme.of(context).accentColor,)),
              error: (e,s)=>Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child:Image.asset("images/internet.png"),
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
              ));
        },
      ),

    );
  }
}
