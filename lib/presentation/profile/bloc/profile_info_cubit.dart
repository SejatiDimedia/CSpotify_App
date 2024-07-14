import 'package:cspotify_app/domain/usecases/auth/get_user_usecase.dart';
import 'package:cspotify_app/presentation/profile/bloc/profile_info_state.dart';
import 'package:cspotify_app/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit() : super(ProfileInfoLoading());

  Future<void> getUser() async {
    var user = await sl<GetUserUsecase>().call();

    user.fold(
      (l) {
        emit(ProfileInfoFailure());
      },
      (userEntity) => {
        emit(
          ProfileInfoLoaded(userEntity: userEntity),
        ),
      },
    );
  }
}
