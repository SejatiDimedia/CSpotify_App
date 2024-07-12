// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cspotify_app/domain/entities/auth/user_entity.dart';

class UserModel {
  String? fullName;
  String? email;
  String? imageURL;

  UserModel({
    this.fullName,
    this.email,
    this.imageURL,
  });

  UserModel.fromJson(Map<String, dynamic> data) {
    fullName = data['name'];
    email = data['email'];
  }
}

extension UserModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      email: email,
      fullName: fullName,
      imageURL: imageURL,
    );
  }
}