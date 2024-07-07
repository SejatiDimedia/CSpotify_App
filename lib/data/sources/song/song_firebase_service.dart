import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cspotify_app/data/models/song/song.dart';
import 'package:cspotify_app/domain/entities/song/song_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSongs();
}

class SongFirebaseServiceImpl extends SongFirebaseService {
  @override
  Future<Either> getNewsSongs() async {
    try {
      List<SongEntity> songs = [];

      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .limit(3)
          .get();

      print("====response data:${data.docs}");

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        songs.add(songModel.toEntity());
      }

      print("====response songs: $songs=======");
      return Right(songs);
    } catch (e) {
      print('error: $e');
      return const Left('An error occurred, Please try again.');
    }
  }
}
