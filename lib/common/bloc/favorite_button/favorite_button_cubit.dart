import 'package:cspotify_app/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:cspotify_app/domain/usecases/song/add_or_remove_favorite_song.dart';
import 'package:cspotify_app/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {
  FavoriteButtonCubit() : super(FavoriteButtonInitial());

  void favoriteButtonUpdated(String songId) async {
    var result =
        await sl<AddOrRemoveFavoriteSongUseCase>().call(params: songId);

    result.fold((l) {}, (isFavorite) {
      emit(FavoriteButtonUpdated(isFavorite: isFavorite));
    });
  }
}