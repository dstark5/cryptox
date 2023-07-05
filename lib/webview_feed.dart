import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class webviewFeed extends StatefulWidget {
  const webviewFeed({Key? key}) : super(key: key);

  @override
  _webviewFeedState createState() => _webviewFeedState();
}

class _webviewFeedState extends State<webviewFeed> {
  // void initState(){
  //   super.initState();
  //   WebView.platform=SurfaceAndroidWebView();
  // }
  bool loading=true;
  @override
  Widget build(BuildContext context) {
    String data=ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar:AppBar(
        title:Text("CryptoX",style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize:21)),
        iconTheme:IconThemeData(color:Colors.white),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl:data,
            javascriptMode:JavascriptMode.unrestricted,
            onProgress:(x){
              if(x>50) {
                if(loading==true) {
                  setState(() {
                    loading = false;
                  });
                }
              }
            },
          ),
          loading?Container(color:Theme.of(context).scaffoldBackgroundColor,child: Center(child:CircularProgressIndicator(color:Theme.of(context).accentColor))):Stack(),
        ],
      )
    );
  }
}
