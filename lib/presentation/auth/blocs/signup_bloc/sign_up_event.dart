part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();
  @override
  List<Object?> get props => [];
}

class SignUpRequested extends SignUpEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  const SignUpRequested(this.email, this.password, this.firstName, this.lastName);

  @override
  List<Object?> get props => [email, password];
}
