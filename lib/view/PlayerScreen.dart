import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:audioplayer/audioplayer.dart';
import 'package:wave/config.dart';
// import 'package:wave/config.dart';
import 'package:wave/wave.dart';

/// This audio player is Based on:
/// - https://github.com/luanpotter/audioplayers/blob/master/example/lib/player_widget.dart
/// - https://github.com/rxlabz/audioplayer/blob/master/example/lib/main.dart

// https://www.soundhelix.com/audio-examples

// state music
enum PlayerState { stopped, playing, paused }

class PlayerScreen extends StatefulWidget {
  final String url;  

  PlayerScreen({Key key, @required this.url})
      : super(key: key);

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  //attr
  String url;
  bool _resultAutoPlay = false;
  bool _autoPlaySt = true;

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

  double _getPositionValue() {
    if (_duration != null) {
      return _position?.inSeconds?.toDouble() ?? 0.0;
    }
    return 0.0;
  }

  double _getMaxPositionValue() {
    if (_duration != null) {
      return _duration?.inSeconds?.toDouble() ?? 0.0;
    }

    return 0.0;
  }

  
  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  
  @override
  void dispose() {
    print("------- Run dispose --------");
    //_audioPlayer.  
    //_onComplete();  
    _positionSubscription.cancel();
    _audioPlayerStateSubscription.cancel();   
    _audioPlayer.stop();      
    /*_playerState = PlayerState.stopped; 
    _duration = Duration(seconds: 0);
    _position = Duration(seconds: 0);
    _audioPlayerState = AudioPlayerState.COMPLETED;  */

    print(_audioPlayer.state);           
    super.dispose();
  }

  
  void _onComplete() {
    setState(() {
      _playerState = PlayerState.stopped;
      _duration = Duration(seconds: 0);
      _position = Duration(seconds: 0);         
    });
  }

  
  void _initAudioPlayer() {
    print("_initAudioPlayer");

    _audioPlayer = AudioPlayer();

    _positionSubscription = _audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        _position = event;        
      });
    });    

    _audioPlayerStateSubscription =
        _audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == AudioPlayerState.PLAYING) {
        print("Listen AudioPlayerState.PLAYING");
        setState(() {
          _duration = _audioPlayer.duration;
        });
      } else if (event == AudioPlayerState.STOPPED) {
        print("Listen AudioPlayerState.STOPPED");
        _onComplete();
        setState(() {
          _position = _duration;
        });
      }
    }, onError: (msg) {
      setState(() {
        _playerState = PlayerState.stopped;
        _duration = Duration(seconds: 0);
        _position = Duration(seconds: 0);
      });
    });
  }

  Future<bool> _autoPlay() async {
    print("Auto PLAY");
    print(_audioPlayer.state);

    if (_autoPlaySt) {
      if ((_playerState == PlayerState.paused ||
                  _playerState == PlayerState.stopped) &&
              _playerState != PlayerState.playing) {
            _autoPlaySt = false;

            print("OKAY autoplay");

            _play().then((value) {
              print("PLAy call");
              _resultAutoPlay = true;
            });
          }
    }

    print("_resultAutoPlay: $_resultAutoPlay");
    print("--------------");

    return _resultAutoPlay;
  }

  Future<bool> _play() async {
    await _audioPlayer.play(widget.url);

    setState(() {
      _playerState = PlayerState.playing;
    });
   
    return true;
  }

  Future<bool> _stop() async {
    await _audioPlayer.stop();
    setState(() {
      _playerState = PlayerState.stopped;
      _position = Duration();
    });

    return true;
  }

  Future<bool> _pause() async {
    await _audioPlayer.pause();
    setState(() {
      _playerState = PlayerState.paused;
    });

    return true;
  }

  Future _mute(bool muted) async {
    await _audioPlayer.mute(muted);
    setState(() {
      isMuted = muted;
    });
  }

  String _getPlayerStateString() {
    if (_playerState == PlayerState.playing) {
      return "Playing";
    } else if (_playerState == PlayerState.paused) {
      return "Paused";
    } else {
      return "Stopped";
    }
  }

  // interface
  @override
  Widget build(BuildContext context) {
    //_play();    
    Widget body = FutureBuilder(
        key: Key("body"),
        future: _autoPlay(),
        builder: (context, snapshot) {
          print("${snapshot.hasData}-${snapshot.data}");
          if (snapshot.hasData && snapshot.data == true) {
            print("snapshot.hasData && snapshot.data == true");
            return Container(
              color: Colors.purple,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    key: Key("wave"),
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        //padding: EdgeInsets.all(15),
                        child: Center(                          
                          // https://pub.dev/packages/wave#-example-tab-
                          child: WaveWidget(                            
                            config: CustomConfig(
                              colors: [
                                Colors.white70,
                                Colors.white54,
                                Colors.white30,
                                Colors.purple,
                              ],
                              durations: [32000, 21000, 18000, 5000],
                              heightPercentages: [0.31, 0.25, 0.15, 0.5],
                              blur: MaskFilter.blur(BlurStyle.inner, 0.1),
                              //gradientBegin: Alignment.centerLeft,
                              //gradientEnd: Alignment.centerRight,
                            ),
                            waveAmplitude: 0,
                            backgroundColor: Colors.transparent,
                            size: Size(double.infinity, 300),
                          ),
                        )
                        /*
                        Icon(
                          Icons.music_note,
                          size: 200,
                          color: Colors.white,
                        )*/
                        ,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                        key: Key("play_but"),
                        icon: Icon(Icons.play_arrow),
                        onPressed: () {
                          //print(_isPlaying);
                          if (!_isPlaying) {
                            _play();
                          }
                        },
                        iconSize: 64,
                        color: Colors.white,
                      ),
                      IconButton(
                          key:  Key("pause_but"),
                          icon: Icon(Icons.pause),
                          onPressed: () {
                            if (_isPlaying) {
                              _pause();
                            }
                          },
                          iconSize: 64,
                          color: Colors.white),
                      IconButton(
                        key: Key('stop_but'),
                        onPressed: () {
                          if (_isPlaying || _isPaused) {
                            _stop();
                          }
                        },
                        iconSize: 64,
                        icon: Icon(Icons.stop),
                        color: Colors.white,
                      ),
                      IconButton(
                        key:  Key("mute_but"),
                        icon: _muteWIcon,
                        onPressed: () {
                          isMuted = !isMuted;
                          if (isMuted) {
                            _muteWIcon = Icon(Icons.volume_off);
                            _mute(true);
                          } else {
                            _muteWIcon = Icon(Icons.volume_mute);
                            _mute(false);
                          }
                        },
                        color: Colors.white,
                        iconSize: 64,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.replay_10),
                              color: Colors.white,
                              iconSize: 45,
                              onPressed: () {
                                _audioPlayer.seek(_getPositionValue() - 10);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.forward_10),
                              color: Colors.white,
                              iconSize: 45,
                              onPressed: () {
                                _audioPlayer.seek(_getPositionValue() + 10);
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Stack(
                          children: [
                            Slider(
                              inactiveColor: Colors.black,
                              activeColor: Colors.white,
                              value: _getPositionValue(),
                              onChanged: (double value) {
                                //print("SLICER: ${value.roundToDouble()}");
                                setState(() {
                                  _position = Duration(seconds: value.toInt());
                                  _audioPlayer.seek(value.roundToDouble());
                                });
                              },
                              min: 0.0,
                              max: _getMaxPositionValue(),
                              divisions: (_getMaxPositionValue() != 0
                                  ? _getMaxPositionValue().toInt()
                                  : 100),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        _position != null
                            ? '${_positionText ?? ''} / ${_durationText ?? ''}'
                            : _duration != null ? _durationText : '',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: CircularProgressIndicator(
                          value: _position != null && _position.inSeconds > 0
                              ? (_position?.inSeconds?.toDouble() ?? 0.0) /
                                  (_duration?.inSeconds?.toDouble() ?? 0.0)
                              : 0.0,
                          valueColor: AlwaysStoppedAnimation(Colors.black),
                          backgroundColor: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Player Status: ${_getPlayerStateString()}',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.purple,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            );
          }
        });

    return Scaffold(
      appBar: AppBar(
        key: Key("app_bar"),
        title: Text("Go Home"),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            print("Backing");
            _pause().then((value) {
              print("PAUSE");
            });

            Navigator.pop(context);
          },
        ),
      ),
      body: body,
    );
  }
}
