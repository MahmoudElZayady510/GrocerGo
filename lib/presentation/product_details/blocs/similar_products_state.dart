part of 'similar_products_bloc.dart';

class SimilarProductsState {}

final class SimilarProductsLoading extends SimilarProductsState {}
final class SimilarProductsLoaded extends SimilarProductsState {
  final List<Grocery> groceries;

  SimilarProductsLoaded(this.groceries);
}
final class SimilarProductsError extends SimilarProductsState {
   final String message;

  SimilarProductsError(this.message);
}
