import 'package:bloc/bloc.dart';
import 'package:groceries/domain/auth/use_cases/logout_user.dart';
import 'package:meta/meta.dart';

part 'signout_event.dart';
part 'signout_state.dart';

class SignoutBloc extends Bloc<SignoutEvent, SignoutState> {
  final LogoutUserUsecase logoutUserUsecase;
  SignoutBloc(this.logoutUserUsecase) : super(SignoutInitial()) {
    on<SignOutRequested>((event, emit) async {
      emit(SignoutLoading());
      try{
        await logoutUserUsecase.call();
        emit(SignoutSuccess());
      }
      catch(e){
        emit(SignoutError(message: e.toString()));
      }
    });
  }
}
