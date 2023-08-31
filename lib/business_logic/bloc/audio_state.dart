part of 'audio_bloc.dart';

abstract class AudioState extends Equatable {
  const AudioState();

  @override
  List<Object> get props => [];
}

class AudioInitial extends AudioState {}

class AudioPlaying extends AudioState {
  final int currentPosition;
  final int maxDuration;

  const AudioPlaying({required this.currentPosition, required this.maxDuration});

  @override
  List<Object> get props => [currentPosition, maxDuration];
}

class AudioPaused extends AudioState {}

class AudioStopped extends AudioState {}

// class AudioCompleted extends AudioState {}
//
// class AudioDurationChanged extends AudioState {
//   final int newDuration;
//
//   const AudioDurationChanged(this.newDuration);
//
//   @override
//   List<Object> get props => [newDuration];
// }
