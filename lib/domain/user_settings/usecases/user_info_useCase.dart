import 'package:firebase_auth/firebase_auth.dart';
import 'package:groceries/data/user_settings/repositories/firebase_user_info.dart';
import 'package:groceries/domain/user_settings/models/User_info.dart';

class FetchUserInfoUsecase{
  final FirebaseUserInfoRepository userInfoRepository;

  FetchUserInfoUsecase(this.userInfoRepository);

  Stream<UserData?> call(){
    return userInfoRepository.getUserInfo();
  }
}