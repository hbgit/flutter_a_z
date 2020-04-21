// Import the test package and Counter class
import 'dart:convert';

import 'package:flutter_a_z/Api.dart';
import 'package:flutter_a_z/model/Video.dart';
import 'package:test/test.dart';

void main() {

  test("Checking video model", (){
    
    String jsonString = 
    """    
  {
   "kind": "youtube#video",
   "etag": "nxOHAKTVB7baOKsQgTtJIyGxcs8/PqmK3dQl2D1Z38JM7ai1MnWM68o",
   "id": "7Y8g0BTXRh4",
   "snippet": {
    "publishedAt": "2020-04-20T14:25:35.000Z",
    "channelId": "UCKy1dAqELo0zrOtPkf0eTMw",
    "title": "The Mandalorian Season 2 Trailer | Disney+",
    "description": "Din Djarin has traveled far, made many enemies, and shouldered the burden of some very precious cargo...but his journey is far from over. The Mandalorian is set after the fall of the Empire and before the emergence of the First Order. We follow the travails of a lone gunfighter in the outer reaches of the galaxy far from the authority of the New Republic.",
    "thumbnails": {
     "default": {
      "url": "https://i.ytimg.com/vi/7Y8g0BTXRh4/default.jpg",
      "width": 120,
      "height": 90
     },
     "medium": {
      "url": "https://i.ytimg.com/vi/7Y8g0BTXRh4/mqdefault.jpg",
      "width": 320,
      "height": 180
     },
     "high": {
      "url": "https://i.ytimg.com/vi/7Y8g0BTXRh4/hqdefault.jpg",
      "width": 480,
      "height": 360
     },
     "standard": {
      "url": "https://i.ytimg.com/vi/7Y8g0BTXRh4/sddefault.jpg",
      "width": 640,
      "height": 480
     },
     "maxres": {
      "url": "https://i.ytimg.com/vi/7Y8g0BTXRh4/maxresdefault.jpg",
      "width": 1280,
      "height": 720
     }
    },
    "channelTitle": "IGN",
    "tags": [
     "IGN",
     "Mando",
     "shows",
     "Disney",
     "Teaser",
     "Sci-Fi",
     "Trailer",
     "Official",
     "Disney +",
     "Season 2",
     "Mandalorian",
     "Baby Yoda",
     "The Child",
     "Star Wars",
     "Moff Gideon",
     "Disney Plus",
     "Star Wars: The Mandalorian",
     "Disney+",
     "mandalorian season 2",
     "mandalorian theme",
     "mandalorian trailer",
     "mandalorian season 2 teaser",
     "mandalorian season 2 trailer",
     "mandalorian season 2 official trailer"
    ],
    "categoryId": "24",
    "liveBroadcastContent": "none",
    "localized": {
     "title": "The Mandalorian Season 2 Trailer | Disney+",
     "description": "Din Djarin has traveled far, made many enemies, and shouldered the burden of some very precious cargo...but his journey is far from over. The Mandalorian is set after the fall of the Empire and before the emergence of the First Order. We follow the travails of a lone gunfighter in the outer reaches of the galaxy far from the authority of the New Republic."
    }
   }
  }
""";

    Map<String, dynamic> youtubeReturn = jsonDecode(jsonString);
    final Video v = Video.fromJson(youtubeReturn);
    expect(v.id, "7Y8g0BTXRh4");
    expect(v.title, "The Mandalorian Season 2 Trailer | Disney+");
    expect(v.description, "Din Djarin has traveled far, made many enemies, and shouldered the burden of some very precious cargo...but his journey is far from over. The Mandalorian is set after the fall of the Empire and before the emergence of the First Order. We follow the travails of a lone gunfighter in the outer reaches of the galaxy far from the authority of the New Republic.");
    expect(v.image, "https://i.ytimg.com/vi/7Y8g0BTXRh4/hqdefault.jpg");
    expect(v.channel, "IGN");
  });

  test("Checking Api call", (){
    Api t1 = Api();
    t1.search("").then((value){
      expect(value.length, isNonZero);      
    });

  });

}

