import 'package:cspotify_app/core/usecases/usecases.dart';
import 'package:cspotify_app/data/models/auth/create_user_req.dart';
import 'package:cspotify_app/domain/repository/auth/auth_repository.dart';
import 'package:cspotify_app/service_locator.dart';
import 'package:dartz/dartz.dart';

class SignupUsecase implements UseCases<Either, CreateUserReq> {
  @override
  Future<Either> call({CreateUserReq? params}) {
    return sl<AuthRepository>().signup(params!);
  }
}
