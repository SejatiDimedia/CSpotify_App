import 'package:cspotify_app/data/repository/auth/auth_repository_impl.dart';
import 'package:cspotify_app/data/repository/song/song_repository_impl.dart';
import 'package:cspotify_app/data/sources/auth/auth_firebase_service.dart';
import 'package:cspotify_app/data/sources/song/song_firebase_service.dart';
import 'package:cspotify_app/domain/repository/auth/auth_repository.dart';
import 'package:cspotify_app/domain/repository/song/song_repository.dart';
import 'package:cspotify_app/domain/usecases/auth/get_user_usecase.dart';
import 'package:cspotify_app/domain/usecases/auth/logout_usecase.dart';
import 'package:cspotify_app/domain/usecases/auth/signin_usecase.dart';
import 'package:cspotify_app/domain/usecases/auth/signup_usecase.dart';
import 'package:cspotify_app/domain/usecases/song/add_or_remove_favorite_song.dart';
import 'package:cspotify_app/domain/usecases/song/get_favorite_song_usecases.dart';
import 'package:cspotify_app/domain/usecases/song/get_news_songs_usecase.dart';
import 'package:cspotify_app/domain/usecases/song/get_play_list.dart';
import 'package:cspotify_app/domain/usecases/song/is_favorite_song.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Services
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl(),
  );

  sl.registerSingleton<SongFirebaseService>(
    SongFirebaseServiceImpl(),
  );

  // Repositories
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(),
  );

  sl.registerSingleton<SongRepository>(
    SongRepositoryImpl(),
  );

  // Usecases
  sl.registerSingleton<SignupUsecase>(
    SignupUsecase(),
  );

  sl.registerSingleton<SigninUsecase>(
    SigninUsecase(),
  );

  sl.registerSingleton<GetNewsSongsUsecase>(
    GetNewsSongsUsecase(),
  );

  sl.registerSingleton<GetPlayListUseCase>(
    GetPlayListUseCase(),
  );

  sl.registerSingleton<AddOrRemoveFavoriteSongUseCase>(
    AddOrRemoveFavoriteSongUseCase(),
  );

  sl.registerSingleton<IsFavoriteSongUseCase>(
    IsFavoriteSongUseCase(),
  );

  sl.registerSingleton<GetUserUsecase>(
    GetUserUsecase(),
  );

  sl.registerSingleton<GetFavoriteSongUsecases>(
    GetFavoriteSongUsecases(),
  );

  sl.registerSingleton<LogoutUsecase>(LogoutUsecase());
}
