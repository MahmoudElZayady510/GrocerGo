part of 'products_bloc.dart';


abstract class ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Grocery> groceries;

  ProductsLoaded(this.groceries);
}

class ProductsError extends ProductsState {
  final String error;

  ProductsError(this.error);
}
