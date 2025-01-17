import 'package:cspotify_app/common/bloc/favorite_button/favorite_button_cubit.dart';
import 'package:cspotify_app/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:cspotify_app/core/configs/theme/app_colors.dart';
import 'package:cspotify_app/domain/entities/song/song_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButton extends StatelessWidget {
  final SongEntity songEntity;
  final Function? function;
  const FavoriteButton({
    required this.songEntity,
    this.function,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteButtonCubit(),
      child: BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
          builder: (context, state) {
        if (state is FavoriteButtonInitial) {
          return IconButton(
            onPressed: () async {
              await context
                  .read<FavoriteButtonCubit>()
                  .favoriteButtonUpdated(songEntity.songId);
              if (function != null) {
                function!();
              }
            },
            icon: Icon(
              songEntity.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_outline_outlined,
              size: 25,
              color: AppColors.darkGrey,
            ),
          );
        }

        if (state is FavoriteButtonUpdated) {
          return IconButton(
            onPressed: () {},
            icon: Icon(
              state.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_outline_outlined,
              size: 25,
              color: AppColors.darkGrey,
            ),
          );
        }
        return Container();
      }),
    );
  }
}
