import 'package:cspotify_app/common/helpers/is_dark_mode.dart';
import 'package:cspotify_app/common/widgets/appbar/app_bar.dart';
import 'package:cspotify_app/common/widgets/favorite_button/favorite_button.dart';
import 'package:cspotify_app/core/configs/constants/app_urls.dart';
import 'package:cspotify_app/domain/usecases/auth/logout_usecase.dart';
import 'package:cspotify_app/presentation/auth/pages/signin_page.dart';
import 'package:cspotify_app/presentation/profile/bloc/favorite_songs_cubit.dart';
import 'package:cspotify_app/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:cspotify_app/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:cspotify_app/presentation/profile/bloc/profile_info_state.dart';
import 'package:cspotify_app/presentation/song_player/pages/song_player_page.dart';
import 'package:cspotify_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
          backgroundColor: context.isDarkMode
              ? const Color(0xff2c2b2b)
              : const Color(0xffFFFFFF),
          title: const Text(
            "Profile",
          ),
          action: IconButton(
            onPressed: () {
              _showLogoutDialog(context);
            },
            icon: const Icon(
              Icons.logout,
            ),
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _profileInfo(context),
          const SizedBox(
            height: 30,
          ),
          _favoriteSongs(),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Logout"),
              onPressed: () async {
                var result = await sl<LogoutUsecase>().call();

                result.fold((l) {
                  var snackbar = SnackBar(content: Text(l));
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                }, (r) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => SigninPage(),
                    ),
                    (route) => false,
                  );
                });
              },
            ),
          ],
        );
      },
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        height: MediaQuery.of(context).size.height / 3.5,
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.isDarkMode ? const Color(0xff2c2b2b) : Colors.white,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
        ),
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
          builder: (context, state) {
            if (state is ProfileInfoLoading) {
              return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              );
            }

            if (state is ProfileInfoLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(state.userEntity.imageURL!),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    state.userEntity.email!,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    state.userEntity.fullName!,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            }

            if (state is ProfileInfoFailure) {
              return const Text("Please try again");
            }

            return Container();
          },
        ),
      ),
    );
  }

  Widget _favoriteSongs() {
    return BlocProvider(
      create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Favorite Songs',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
                builder: (context, state) {
              if (state is FavoriteSongsLoading) {
                return const CircularProgressIndicator();
              }

              if (state is FavoriteSongsLoaded) {
                if (state.favoriteSongs.isEmpty) {
                  return const Text("Favorite songs don't exist");
                }

                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => SongPlayerPage(
                              songEntity: state.favoriteSongs[index],
                            ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      '${AppURLs.coverFirestorage}${state.favoriteSongs[index].artist} - ${state.favoriteSongs[index].title}.jpeg?${AppURLs.mediaAlt}',
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        200, // Atur lebar maksimum yang diinginkan
                                    child: Text(
                                      state.favoriteSongs[index].title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      overflow: TextOverflow
                                          .ellipsis, // Tambahkan ellipsis
                                      maxLines:
                                          1, // Pastikan teks tetap dalam satu baris
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    state.favoriteSongs[index].artist,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                state.favoriteSongs[index].duration
                                    .toString()
                                    .replaceAll('.', ':'),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              FavoriteButton(
                                  songEntity: state.favoriteSongs[index],
                                  key: UniqueKey(),
                                  function: () {
                                    context
                                        .read<FavoriteSongsCubit>()
                                        .removeSong(index);
                                  })
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 20,
                  ),
                  itemCount: state.favoriteSongs.length,
                );
              }

              if (state is FavoriteSongsFailure) {
                return const Text("Please try again");
              }

              return Container();
            })
          ],
        ),
      ),
    );
  }
}
