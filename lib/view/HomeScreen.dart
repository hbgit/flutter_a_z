import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:audioplayer/audioplayer.dart';

/// This audio player is Based on:
/// - https://github.com/luanpotter/audioplayers/blob/master/example/lib/player_widget.dart
/// - https://github.com/rxlabz/audioplayer/blob/master/example/lib/main.dart

// https://www.soundhelix.com/audio-examples

// state music
enum PlayerState { stopped, playing, paused }

class HomeScreen extends StatefulWidget {
  final String url;  

  HomeScreen({Key key, @required this.url})
      : super(key: key);

  @override  
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  //attr
  String url;  

  AudioPlayer _audioPlayer;  
  PlayerState _playerState = PlayerState.stopped;  
  Duration _duration;
  Duration _position;
  
  StreamSubscription _positionSubscription;  
  StreamSubscription _audioPlayerStateSubscription;

  bool isMuted = false;  
  Widget _muteWIcon = Icon(Icons.volume_mute);

  // class actions
  get _isPlaying => _playerState == PlayerState.playing;
  get _isPaused => _playerState == PlayerState.paused;
  get _durationText => 
    _duration != null ? _duration.toString().split('.').first : '';
  get _positionText => 
    _position != null ? _position.toString().split('.').first : '';

  double _getPositionValue(){
    if(_duration != null){
      return _position?.inMilliseconds?.toDouble() ?? 0.0;
    }

    return 0.0;
  }

  double _getMaxPositionValue(){
    if(_duration != null){
      return _duration.inMilliseconds.toDouble();
    }

    return 0;
  }


  
  

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.stop();   
    _positionSubscription.cancel();
    _audioPlayerStateSubscription.cancel();
    _audioPlayer.stop();   
    super.dispose();
  }

  void _onComplete() {
    setState(() => _playerState = PlayerState.stopped);
  }

  void _initAudioPlayer() {
    _audioPlayer = AudioPlayer();
    
    _positionSubscription = _audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        _position = event;
        //print(_position);
      });
    });

    _audioPlayerStateSubscription = _audioPlayer.onPlayerStateChanged.listen((event) { 
      
      if(event == AudioPlayerState.PLAYING){
        setState(() {
          _duration = _audioPlayer.duration;
        });
      }else if(event == AudioPlayerState.STOPPED){
        _onComplete();
        setState(() {
          _position = _duration;
        });
      }
     }, onError: (msg){
       setState(() {
        _playerState = PlayerState.stopped;
        _duration = Duration(seconds: 0);
        _position = Duration(seconds: 0);
       });
     });

  }

  Future _play() async {
    print("PLAY");    

    await _audioPlayer.play(widget.url);    
    setState(() {
      _playerState = PlayerState.playing;
    });
    
  }

  Future _stop() async {
    await _audioPlayer.stop();
    setState(() {
      _playerState = PlayerState.stopped;
      _position = Duration();
    });
  }

  Future _pause() async {
    await _audioPlayer.pause();
    setState(() {
      _playerState = PlayerState.paused;
    });
  }

  Future _mute(bool muted) async {
    await _audioPlayer.mute(muted);
    setState(() {
      isMuted = muted;
    });
  }

  // interface
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Music Net Player"),
      ),
      body: Container(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Icon(
                    Icons.music_note,
                    size: 200,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: (){
                    print(_isPlaying);
                    if(!_isPlaying){
                      _play();
                    }
                  },
                  iconSize: 64,
                  color: Colors.cyan,
                ),
                IconButton(
                  icon: Icon(Icons.pause),
                  onPressed: (){
                    if(_isPlaying){
                      _pause();
                    }
                  },
                  iconSize: 64,
                  color: Colors.cyan
                ),
                IconButton(  
                  key: Key('stop_button'),                                  
                  onPressed: (){
                    if ( _isPlaying || _isPaused){
                      _stop();
                    }
                  },
                  iconSize: 64,
                  icon: Icon(Icons.stop),
                  color: Colors.cyan,
                ),
                IconButton(
                  icon: _muteWIcon,
                  onPressed: (){
                    isMuted = !isMuted;                    
                    if(isMuted){
                      _muteWIcon = Icon(Icons.volume_off);
                      _mute(true);
                    }else{
                      _muteWIcon = Icon(Icons.volume_mute);
                      _mute(false);
                    }                      
                  },
                  color: Colors.cyan,
                  iconSize: 64,
                ),
                IconButton(
                        icon: Icon(Icons.forward_10),
                        onPressed: (){
                          print(_getPositionValue());
                          print(_getMaxPositionValue());
                          _audioPlayer.seek(_getPositionValue()*10);
                          
                          
                        },
                      ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Stack(
                    children: [
                      Slider(
                          value: _getPositionValue(),
                          onChanged: (double value) {
                            print(value);
                            print((value/100).roundToDouble());
                            print(_getMaxPositionValue());
                            return _audioPlayer.seek((value/100).roundToDouble());
                          },
                          min: 0.0,
                          max: _getMaxPositionValue(),
                          divisions: 10,
                      ),                      
                    ],
                  ),
                ),
                Text(
                  _position != null
                      ? '${_positionText ?? ''} / ${_durationText ?? ''}'
                      : _duration != null ? _durationText : '',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
            Text('State: $_playerState')
          ],
        ),
      ),
    );
  }
}
