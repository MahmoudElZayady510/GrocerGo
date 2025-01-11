part of 'best_selling_bloc.dart';

class BestSellingState {}

final class BestSellingLoading extends BestSellingState {}
final class BestSellingLoaded extends BestSellingState {
  final List<Grocery> groceries;

  BestSellingLoaded(this.groceries);
}
final class BestSellingError extends BestSellingState {
  final String message;

  BestSellingError(this.message);
}