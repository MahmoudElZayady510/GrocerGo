part of 'user_info_bloc.dart';

class UserInfoState {}

final class UserInfoLoading extends UserInfoState {}
final class UserInfoLoaded extends UserInfoState {
  final UserData userData;

  UserInfoLoaded(this.userData);
}
