part of 'sign_in_bloc.dart';

sealed class SignInState extends Equatable {
  const SignInState();
  List<Object?> get props => [];
}


class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {}

class SignInError extends SignInState {
  final String message;

  const SignInError(this.message);

  @override
  List<Object?> get props => [message];
}
