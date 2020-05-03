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

class PlayerScreen extends StatefulWidget {
  final String url;

  PlayerScreen({Key key, @required this.url}) : super(key: key);

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
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

  double _getPositionValue() {
    if (_duration != null) {
      print("POSITION: ${_position?.inSeconds?.toDouble() ?? 0.0}");
      return _position?.inSeconds?.toDouble() ?? 0.0;
    }

    return 0.0;
  }

  double _getMaxPositionValue() {
    if (_duration != null) {
      print("DURATION: ${_duration?.inSeconds?.toDouble() ?? 0.0}");
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

    _audioPlayerStateSubscription =
        _audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == AudioPlayerState.PLAYING) {
        setState(() {
          _duration = _audioPlayer.duration;
        });
      } else if (event == AudioPlayerState.STOPPED) {
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


  String _getPlayerStateString(){
    if(_playerState == PlayerState.playing){
      return "Playing";
    }else if(_playerState == PlayerState.paused){
      return "Paused";
    }else{
      return "Stopped";
    }
  }


  // interface
  @override
  Widget build(BuildContext context) {

    //_play();

    return Scaffold(
      appBar: AppBar(
        title: Text("Go Home"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.purple,
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
                    color: Colors.white,
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
                    icon: Icon(Icons.pause),
                    onPressed: () {
                      if (_isPlaying) {
                        _pause();
                      }
                    },
                    iconSize: 64,
                    color: Colors.white),
                IconButton(
                  key: Key('stop_button'),
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
                          print("SLICER: ${value.roundToDouble()}");
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
                    color: Colors.white
                  ),
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
              style: TextStyle(
                fontSize: 15,
                color: Colors.white
              ), 
            )
          ],
        ),
      ),
    );
  }
}
