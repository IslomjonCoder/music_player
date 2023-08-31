import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'audio_event.dart';

part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  PlayerState _playerState = PlayerState.stopped;
  late int maxDuration;

  AudioBloc() : super(AudioInitial()) {
    on<StartedAudio>(_startAudio);
    on<PlayAudio>(_playAudio);
    on<PauseAudio>(_pauseAudio);
    on<StopAudio>(_stopAudio);
    on<SeekAudio>(_seekAudio);
    on<ChangeDurationAudio>(_changeDurationAudio);
    on<CompleteAudio>(_completeAudio);

    _registerListeners();
  }

  void _registerListeners() {
    _audioPlayer.onPositionChanged.listen((duration) {
      add(ChangeDurationAudio(duration.inSeconds));
    });
    _audioPlayer.onDurationChanged.listen((duration) {
      maxDuration = duration.inSeconds;
    });
    _audioPlayer.onPlayerComplete.listen((event) {
      add(CompleteAudio());
    });
  }

  _startAudio(StartedAudio event, Emitter<AudioState> emit) async {
    await _audioPlayer.play(DeviceFileSource(event.audioUrl));
    maxDuration = (await _audioPlayer.getDuration())!.inSeconds;
    _playerState = PlayerState.playing;

    emit(AudioPlaying(currentPosition: 0, maxDuration: maxDuration));
  }

  _playAudio(PlayAudio event, Emitter<AudioState> emit) async {
    if (_playerState == PlayerState.paused) {
      await _audioPlayer.resume();
      _playerState = PlayerState.playing;
      emit(AudioPlaying(
          currentPosition: (await _audioPlayer.getCurrentPosition())!.inSeconds,
          maxDuration: maxDuration));
    }
  }

  _pauseAudio(PauseAudio event, Emitter<AudioState> emit) async {
    if (_playerState == PlayerState.playing) {
      await _audioPlayer.pause();
      _playerState = PlayerState.paused;
      emit(AudioPaused());
    }
  }

  _stopAudio(StopAudio event, Emitter<AudioState> emit) async {
    if (_playerState == PlayerState.playing || _playerState == PlayerState.paused) {
      await _audioPlayer.stop();
      _playerState = PlayerState.stopped;
      emit(AudioStopped());
    }
  }

  _seekAudio(SeekAudio event, Emitter<AudioState> emit) async {
    await _audioPlayer.seek(Duration(seconds: event.targetPosition));
    emit(AudioPlaying(currentPosition: event.targetPosition, maxDuration: maxDuration));
  }

  _changeDurationAudio(ChangeDurationAudio event, Emitter<AudioState> emit) async {
    emit(AudioPlaying(currentPosition: event.newDuration, maxDuration: maxDuration));
  }

  _completeAudio(CompleteAudio event, Emitter<AudioState> emit) async {
    _playerState = PlayerState.stopped;
    emit(AudioStopped());
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    return super.close();
  }
}
