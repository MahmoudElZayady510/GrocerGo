import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../../../domain/auth/use_cases/register_user.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;
  SignUpBloc(this.signUpUseCase) : super(SignUpInitial()) {
    on<SignUpRequested>(_onSignUpRequested);
  }



  Future<void> _onSignUpRequested(
      SignUpRequested event,
      Emitter<SignUpState> emit,
      ) async {
    emit(SignUpLoading());
    try {
      await signUpUseCase.call(event.email,event.password , event.firstName , event.lastName);
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpFailure(e.toString()));
    }
  }
}
