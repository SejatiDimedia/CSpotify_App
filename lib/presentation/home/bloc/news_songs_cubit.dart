import 'package:cspotify_app/domain/usecases/song/get_news_songs_usecase.dart';
import 'package:cspotify_app/presentation/home/bloc/news_songs_state.dart';
import 'package:cspotify_app/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {
  NewsSongsCubit() : super(NewSongsLoading());

  Future<void> getNewsSongs() async {
    var returnedSongs = await sl<GetNewsSongsUsecase>().call();
    returnedSongs.fold((l) {
      print(l);
      emit(NewsSongsLoadFailure());
    }, (data) {
      print('load data: $data====');
      emit(NewsSongsLoaded(songs: data));
    });
  }
}
