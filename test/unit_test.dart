// Import the test package and Counter class
import 'dart:convert';

import 'package:flutter_a_z/model/Music.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test("Checking task model", () async {
    
         

    String jsonString = """    
    {
      "name": "SoundHelix Song 1",
      "coverImg": null,
      "artistName": "T. Schürger",
      "urlMusic":  "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"
    }    
    """;

    //print(jsonString);
    //print(json.decode(jsonString));

    Music song = Music.fromJson(json.decode(jsonString));
    
    expect(song.name, "SoundHelix Song 1");
    expect(song.coverImg, null);
    expect(song.artistName, "T. Schürger");
    expect(song.urlMusic, "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3");
    
    
  });  

}
