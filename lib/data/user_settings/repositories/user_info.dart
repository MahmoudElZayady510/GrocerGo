import 'package:groceries/domain/user_settings/models/User_info.dart';

abstract class UserInfoRepository{
  Stream<UserData?> getUserInfo();
}