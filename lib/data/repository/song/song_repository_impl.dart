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

  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId) async {
    return await sl<SongFirebaseService>().addOrRemoveFavoriteSong(songId);
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    return await sl<SongFirebaseService>().isFavoriteSong(songId);
  }

  @override
  Future<Either> getUserFavoriteSongs() async {
    return await sl<SongFirebaseService>().getUserFavoriteSongs();
  }
}
