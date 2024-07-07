import 'package:cspotify_app/core/usecases/usecases.dart';
import 'package:cspotify_app/domain/repository/song/song_repository.dart';
import 'package:cspotify_app/service_locator.dart';
import 'package:dartz/dartz.dart';

class GetNewsSongsUsecase implements UseCases<Either, dynamic> {
  @override
  Future<Either> call({params}) {
    return sl<SongRepository>().getNewsSongs();
  }
}
