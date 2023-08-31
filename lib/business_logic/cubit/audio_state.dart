part of 'audio_cubit.dart';

abstract class AudioPlaylistState extends Equatable {
  const AudioPlaylistState();

  @override
  List<Object?> get props => [];
}

class AudioPlaylistInitial extends AudioPlaylistState {
  @override
  List<Object> get props => [];
}

class AudioLoadSuccess extends AudioPlaylistState {
  final List<SongModel> songs;

  const AudioLoadSuccess(this.songs);

  @override
  List<Object> get props => [songs];
}

class AudioLoadFailure extends AudioPlaylistState {}
