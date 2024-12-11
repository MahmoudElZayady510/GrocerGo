import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:groceries/data/auth/repository/auth_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final FirebaseAuthRepository authRepository;
  SignUpBloc(this.authRepository) : super(SignUpInitial()) {
    on<SignUpRequested>(_onSignUpRequested);
  }



  Future<void> _onSignUpRequested(
      SignUpRequested event,
      Emitter<SignUpState> emit,
      ) async {
    emit(SignUpLoading());
    try {
      await authRepository.signUp(event.email,event.password);
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpFailure(e.toString()));
    }
  }
}
