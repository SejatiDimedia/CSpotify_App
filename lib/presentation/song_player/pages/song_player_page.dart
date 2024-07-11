// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cspotify_app/core/configs/constants/app_urls.dart';
import 'package:cspotify_app/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:cspotify_app/common/widgets/appbar/app_bar.dart';
import 'package:cspotify_app/domain/entities/song/song_entity.dart';

class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity;
  const SongPlayerPage({
    super.key,
    required this.songEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: const Text(
          "Now Playing",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        action: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert_rounded,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        child: Column(
          children: [
            _songCover(context),
            const SizedBox(
              height: 20,
            ),
            _songDetail(),
          ],
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            '${AppURLs.coverFirestorage}${songEntity.artist}-${songEntity.title}.jpeg?${AppURLs.mediaAlt}',
          ),
        ),
      ),
    );
  }

  Widget _songDetail() {
    return Row(
      children: [
        Expanded(
          // Ensures the Row's children have constraints
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                songEntity.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
                overflow: TextOverflow.ellipsis, // Adds ellipsis
                maxLines: 1, // Ensures it stays on one line
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                songEntity.artist,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.favorite_outline_outlined,
            size: 35,
            color: AppColors.darkGrey,
          ),
        )
      ],
    );
  }
}
