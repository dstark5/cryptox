import 'package:flutter/material.dart';



class about extends StatelessWidget {
  const about({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width/1.5;
    return Scaffold(
        appBar:AppBar(
          title:Text("CryptoX",style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize:21)),
          iconTheme:IconThemeData(color:Colors.white),
        ),
      body: Container(
        decoration:BoxDecoration(
          gradient: LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors: [Colors.blue,Colors.deepPurple,Colors.red]),
        ),
        child:Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
              child: Center(child: Image.asset("images/splash.png",width:width)),
            ),
            SizedBox(height: 25),
            Center(
              child:Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text("CryptoX",style: TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize:23)),
              ),
            ),
            Center(
              child:Padding(
                padding: const EdgeInsets.all(9.0),
                child: Text("V 1.5",style: TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize:21)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
