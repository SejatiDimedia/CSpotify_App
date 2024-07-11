import 'package:cspotify_app/data/sources/song/song_firebase_service.dart';
import 'package:cspotify_app/domain/repository/song/song_repository.dart';
import 'package:cspotify_app/service_locator.dart';
import 'package:dartz/dartz.dart';

class SongRepositoryImpl extends SongRepository {
  @override
  Future<Either> getNewsSongs() async {
    return await sl<SongFirebaseService>().getNewsSongs();
  }

  @override
  Future<Either> getPlayList() async {
    return await sl<SongFirebaseService>().getPlayList();
  }
}
