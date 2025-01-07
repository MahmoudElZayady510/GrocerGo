import 'package:bloc/bloc.dart';
import 'package:groceries/domain/user_settings/models/User_info.dart';
import 'package:groceries/domain/user_settings/usecases/user_info_useCase.dart';
import 'package:meta/meta.dart';

part 'user_info_event.dart';
part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {

  final FetchUserInfoUsecase userInfoUsecase;
  UserInfoBloc(this.userInfoUsecase) : super(UserInfoLoading()) {
    on<FetchUserInfo>((event, emit) async {
      emit(UserInfoLoading());
      final userInfo = await userInfoUsecase.call().first;
      if (userInfo != null){
        emit(UserInfoLoaded(userInfo));
      }

      //bad code here
    });
  }
}
