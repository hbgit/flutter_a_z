import 'package:flutter_a_z/model/Video.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const YOUTUBE_KEY_API = "AIzaSyBACpL_fiyVRJtItcspImFC1Ar8vDz5kfg";
const ID_CHANNEL = "UCVHFbqXqoYvEWM1Ddxl0QDg";
const URL_BASE = "https://www.googleapis.com/youtube/v3/";

 class Api{

   Future<List<Video>> search(String query) async {

     http.Response response = await http.get(
       URL_BASE + "search"
       "?part=snippet"
       "&type=video"
       "&maxResults=20"
       "&order=date"
       "&key=$YOUTUBE_KEY_API"
       "&channelId=$ID_CHANNEL"
       "&q=$query"      
     );

     if( response.statusCode ==  200){
       
       Map<String, dynamic> jsonData = json.decode( response.body );

       List<Video> video = jsonData["items"].map<Video>(
         (map){
           return Video.fromJson(map);
         }
       ).toList();

       return video;

     }else{
       List v = [];
       return v;
     }
     
   }
 }