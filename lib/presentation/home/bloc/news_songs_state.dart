import 'package:cspotify_app/domain/entities/song/song_entity.dart';

abstract class NewsSongsState {}

class NewSongsLoading extends NewsSongsState {}

class NewsSongsLoaded extends NewsSongsState {
  final List<SongEntity> songs;
  NewsSongsLoaded({required this.songs});
}

class NewsSongsLoadFailure extends NewsSongsState {}
