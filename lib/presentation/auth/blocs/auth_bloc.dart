// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../domain/auth/use_cases/login_user.dart';
// import '../../../domain/auth/use_cases/logout_user.dart';
// import '../../../domain/auth/use_cases/register_user.dart';
// part 'auth_event.dart';
// part 'auth_state.dart';
//
// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final RegisterUser registerUser;
//   final LoginUser loginUser;
//   final LogoutUser logoutUser;
//
//   AuthBloc({
//     required this.registerUser,
//     required this.loginUser,
//     required this.logoutUser,
//   }) : super(AuthInitial()) {
//     on<RegisterUserEvent>(_onRegisterUser);
//     on<LoginUserEvent>(_onLoginUser);
//     on<LogoutUserEvent>(_onLogoutUser);
//   }
//
//   Future<void> _onRegisterUser(
//       RegisterUserEvent event,
//       Emitter<AuthState> emit,
//       ) async {
//     emit(AuthLoading());
//     try {
//       final user = await registerUser(event.email, event.password);
//       if (user != null) {
//         emit(AuthSuccess(user));
//       } else {
//         emit(AuthFailure('Registration failed. Unknown error occurred.'));
//       }
//     } catch (e) {
//       emit(AuthFailure(e.toString()));
//     }
//   }
//
//   Future<void> _onLoginUser(
//       LoginUserEvent event,
//       Emitter<AuthState> emit,
//       ) async {
//     emit(AuthLoading());
//     try {
//       final user = await loginUser(event.email, event.password);
//       if (user != null) {
//         emit(AuthSuccess(user));
//       } else {
//         emit(AuthFailure('Login failed. Invalid credentials.'));
//       }
//     } catch (e) {
//       emit(AuthFailure(e.toString()));
//     }
//   }
//
//   Future<void> _onLogoutUser(
//       LogoutUserEvent event,
//       Emitter<AuthState> emit,
//       ) async {
//     emit(AuthLoading());
//     try {
//       await logoutUser(); // Logout logic
//       emit(AuthLoggedOut()); // Emit logged-out state
//     } catch (e) {
//       emit(AuthFailure(e.toString()));
//     }
//   }
// }
//
