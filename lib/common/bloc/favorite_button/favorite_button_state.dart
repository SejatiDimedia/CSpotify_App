// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class FavoriteButtonState {}

class FavoriteButtonInitial extends FavoriteButtonState {}

class FavoriteButtonUpdated extends FavoriteButtonState {
  final bool isFavorite;
  FavoriteButtonUpdated({
    required this.isFavorite,
  });
}
