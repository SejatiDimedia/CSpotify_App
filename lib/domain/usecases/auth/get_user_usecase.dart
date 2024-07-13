import 'package:cspotify_app/core/usecases/usecases.dart';
import 'package:cspotify_app/domain/repository/auth/auth_repository.dart';
import 'package:cspotify_app/service_locator.dart';
import 'package:dartz/dartz.dart';

class GetUserUsecase implements UseCases<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<AuthRepository>().getUser();
  }
}
