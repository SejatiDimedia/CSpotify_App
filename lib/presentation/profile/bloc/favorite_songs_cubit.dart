import 'package:cspotify_app/domain/entities/song/song_entity.dart';
import 'package:cspotify_app/domain/usecases/song/get_favorite_song_usecases.dart';
import 'package:cspotify_app/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:cspotify_app/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteSongsCubit extends Cubit<FavoriteSongsState> {
  FavoriteSongsCubit() : super(FavoriteSongsLoading());

  List<SongEntity> favoriteSongs = [];

  Future<void> getFavoriteSongs() async {
    var result = await sl<GetFavoriteSongUsecases>().call();

    result.fold((l) {
      emit(FavoriteSongsFailure());
    }, (r) {
      favoriteSongs = r;
      emit(FavoriteSongsLoaded(favoriteSongs: favoriteSongs));
    });
  }

  void removeSong(int index) {
    favoriteSongs.removeAt(index);
    emit(FavoriteSongsLoaded(favoriteSongs: favoriteSongs));
  }
}
