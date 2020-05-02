import 'package:flutter/material.dart';

class Music{

  String name;
  String coverImg;
  String artistName;
  String urlMusic;

  Music({
    this.name, 
    this.coverImg,
    this.artistName,
    @required this.urlMusic
  });

  factory Music.fromJson(Map<String, dynamic> json){
    return Music(
      name: json["name"],
      coverImg: json["coverImg"],
      artistName: json["artistName"],
      urlMusic: json["urlMusic"]      
    );
  }


}