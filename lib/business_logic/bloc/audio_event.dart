part of 'audio_bloc.dart';

abstract class AudioEvent extends Equatable {
  const AudioEvent();

  @override
  List<Object?> get props => [];
}

class StartedAudio extends AudioEvent {
  final String audioUrl;

  const StartedAudio({required this.audioUrl});

  @override
  List<Object> get props => [audioUrl];
}

class PlayAudio extends AudioEvent {}

class PauseAudio extends AudioEvent {}

class StopAudio extends AudioEvent {}

class SeekAudio extends AudioEvent {
  final int targetPosition;

  const SeekAudio({required this.targetPosition});

  @override
  List<Object?> get props => [targetPosition];
}

class NextAudio extends AudioEvent {}

class PreviousAudio extends AudioEvent {}

// ---------------------------------------------------
class CompleteAudio extends AudioEvent {}

class ChangeDurationAudio extends AudioEvent {
  final int newDuration;

  const ChangeDurationAudio(this.newDuration);

  @override
  List<Object> get props => [newDuration];
}
