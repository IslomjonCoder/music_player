import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:untitled7/data/repository/audio_repository.dart';

part 'audio_state.dart';

class AudioCubit extends Cubit<AudioPlaylistState> {
  final AudioRepository _repository = AudioRepository();

  AudioCubit() : super(AudioPlaylistInitial());
  int currentSong = -1;
  Future<void> fetchSongs() async {
    try {
      final songs = await _repository.getAllSongs();
      songs.isSuccess ? emit(AudioLoadSuccess(songs.data)) : emit(AudioLoadFailure());
    } catch (e) {
      emit(AudioLoadFailure());
    }
  }
}
