import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/auth/repository/auth_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';


class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final FirebaseAuthRepository authRepository;

  SignInBloc({required this.authRepository}) : super(SignInInitial()) {
    on<SignInRequested>(_onSignInRequested);
  }

  Future<void> _onSignInRequested(
      SignInRequested event,
      Emitter<SignInState> emit,
      ) async {
    emit(SignInLoading());
    try {
      await authRepository.signIn(event.email, event.password);
      emit(SignInSuccess());
    } catch (e) {
      emit(SignInError(e.toString()));
    }
  }
}
