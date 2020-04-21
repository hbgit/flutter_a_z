// Import the test package and Counter class
import 'dart:convert';

import 'package:flutter_a_z/Api.dart';
import 'package:flutter_a_z/model/Video.dart';
import 'package:test/test.dart';

void main() {
  test("Checking video model", () {
    String jsonString = """ 
  {
    "items": [   
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
    ]
  }
""";

    Map<String, dynamic> youtubeReturn = json.decode(jsonString);
    print(youtubeReturn["items"]);
    //final Video v = Video.fromJson(youtubeReturn);
    List<Video> v = youtubeReturn["items"].map<Video>((map) {
      return Video.fromJson(map);
    }).toList();

    print(v);
    print(v[0]);

    /*
    expect(v[0].id, "7Y8g0BTXRh4");
    expect(v[0].title, "The Mandalorian Season 2 Trailer | Disney+");
    expect(v[0].description,
        "Din Djarin has traveled far, made many enemies, and shouldered the burden of some very precious cargo...but his journey is far from over. The Mandalorian is set after the fall of the Empire and before the emergence of the First Order. We follow the travails of a lone gunfighter in the outer reaches of the galaxy far from the authority of the New Republic.");
    expect(v[0].image, "https://i.ytimg.com/vi/7Y8g0BTXRh4/hqdefault.jpg");
    expect(v[0].channel, "IGN");
    */
  });

  test("Checking Api call", () {
    Api t1 = Api();
    t1.search("").then((value) {
      expect(value.length, isNonZero);
    });
  });
}
