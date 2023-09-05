import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:untitled7/data/models/result_model.dart';

class AudioRepository {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  Future<Result<List<SongModel>>> getAllSongs() async {
    // Map<Permission, PermissionStatus> statuses = await [
    //   Permission.storage,
    //   Permission.manageExternalStorage,
    //   Pe rmission.mediaLibrary,
    // ].request();
    // final PermissionStatus permissionStatus = await Permission.storage.request();
    //
    // if (permissionStatus.isGranted) {

    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.manageExternalStorage,
    ].request();

    var storage = statuses[Permission.storage];
    var manageExternalStorage = statuses[Permission.manageExternalStorage];
    if (storage!.isGranted || manageExternalStorage!.isGranted) {
      return Result.success(await _audioQuery.querySongs(
        sortType: SongSortType.ALBUM,
      ));
    } else {
      return Result.fail('Permission is not granted');
    }
  }
}
