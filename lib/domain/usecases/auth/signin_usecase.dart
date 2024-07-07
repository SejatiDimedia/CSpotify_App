import 'package:cspotify_app/core/usecases/usecases.dart';
import 'package:cspotify_app/data/models/auth/signin_user_req.dart';
import 'package:cspotify_app/domain/repository/auth/auth_repository.dart';
import 'package:cspotify_app/service_locator.dart';
import 'package:dartz/dartz.dart';

class SigninUsecase implements UseCases<Either, SigninUserReq> {
  @override
  Future<Either> call({SigninUserReq? params}) {
    return sl<AuthRepository>().signin(params!);
  }
}
