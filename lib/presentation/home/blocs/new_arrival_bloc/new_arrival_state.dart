part of 'new_arrival_bloc.dart';

class NewArrivalState {}

final class NewArrivalLoading extends NewArrivalState {}
final class NewArrivalLoaded extends NewArrivalState {
  final List<Grocery> groceries;

  NewArrivalLoaded(this.groceries);
}
final class NewArrivalError extends NewArrivalState {
  final String message;

  NewArrivalError(this.message);
}
