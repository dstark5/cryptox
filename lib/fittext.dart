import 'package:flutter/material.dart';


Widget fitid(snapshot){
  if(snapshot.length<=23){
    return Text(
      snapshot,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize:15
      ),
      overflow:TextOverflow.clip,
    );
  }if(snapshot.length<29){
    return Text(
      snapshot,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize:13
      ),
      overflow:TextOverflow.clip,
    );
  }else{
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        snapshot,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize:10
        ),
        overflow:TextOverflow.clip,
      ),
    );
  }

}



Widget fittext(snapshot,colors){
  if(snapshot.length<8){
    return Text(
      snapshot,
      style: TextStyle(
        fontWeight: FontWeight.bold,color: colors,
        fontSize:15
      ),
      overflow:TextOverflow.clip,
    );
  }if(snapshot.length<10){
    return Text(
      snapshot,
      style: TextStyle(
          fontWeight: FontWeight.bold,color: colors,
          fontSize:13
      ),
      overflow:TextOverflow.clip,
    );
  }else{
    return FittedBox(
      fit:BoxFit.scaleDown,
      child: Text(
        snapshot,
        style: TextStyle(
            fontWeight: FontWeight.bold,color: colors,
            fontSize:10
        ),
        overflow:TextOverflow.clip,
      ),
    );
  }
}



Widget fit(snapshot){
  if(snapshot.length<8){
    return Text(
      snapshot,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize:15,
      ),
      overflow:TextOverflow.clip,
    );
  }if(snapshot.length<10){
    return Text(
      snapshot,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize:13,
      ),
      overflow:TextOverflow.clip,
    );
  }else{
    return Text(
      snapshot,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize:10,
      ),
      overflow:TextOverflow.clip,
    );
  }
}
