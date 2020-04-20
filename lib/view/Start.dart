import 'package:flutter/material.dart';
import 'package:flutter_a_z/Api.dart';
import 'package:flutter_a_z/model/Video.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Start extends StatefulWidget {
  //Start({Key key}) : super(key: key);

  final String query;
  final String op;  
  Start(this.query, this.op);

  @override
  _StartState createState() => _StartState();
  
}

class _StartState extends State<Start> {

  //Future<void> _

  Future<void> _launchURL(String urlId) async {
          
    // check if the app is running on web or mobile
    if (kIsWeb == false) {
      FlutterYoutube.playYoutubeVideoById(
        apiKey: YOUTUBE_KEY_API, 
        videoId: urlId,
        autoPlay: true,
        fullScreen: true
      );

    } else {
      // Adopting a web solution
      String url = "https://www.youtube.com/watch?v=" + urlId;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  _listVideos(String query) {
    Api api = Api();
    if(widget.op == "topDate"){
       return api.search(query);
    }else if(widget.op == "hot"){
      return api.opSearch("rating");
    }else if(widget.op == "view"){
      return api.opSearch("viewCount");
    }else if(widget.op == "title"){
      return api.opSearch("title");
    }    

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(Start oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>>(
      key: Key("frame_build_start"),
      future: _listVideos(widget.query),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          //return Text("NONE");
          //break;

          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          //break;

          case ConnectionState.active:
          //return Text("ACTIVE");
          //break;

          case ConnectionState.done:
            if (snapshot.hasData) {
              return ListView.separated(
                  key: Key("list_videos"),
                  itemBuilder: (context, index) {
                    List<Video> videos = snapshot.data;
                    Video video = videos[index];

                    return GestureDetector(
                      onTap: () => setState(() {
                        print("tap");
                        this._launchURL(video.id);
                      }),
                      child: Column(
                        children: <Widget>[
                          Container(
                            key: Key("img_video"),
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(video.image),
                            )),
                          ),
                          ListTile(
                            key: Key("list_desc_video"),
                            title: Text(video.title),
                            subtitle: Text(video.channel),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                        height: 2,
                        color: Colors.grey,
                      ),
                  itemCount: snapshot.data.length);
            } else {
              return Container(
                child: Text("No data found, sorry :("),
              );
            }
            break;
          default: // Is required by this version of Flutter
            return Text("Sorry :(");
        }
      },
    );
  }
}
