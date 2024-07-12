import 'package:cspotify_app/core/usecases/usecases.dart';
import 'package:cspotify_app/domain/repository/song/song_repository.dart';
import 'package:cspotify_app/service_locator.dart';

class IsFavoriteSongUseCase implements UseCases<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    return await sl<SongRepository>().isFavoriteSong(params!);
  }
}
