part of 'products_bloc.dart';


abstract class ProductsEvent {}
class FetchGroceryList extends ProductsEvent {}
class FetchGroceryListByCategory extends ProductsEvent {
  final String category;

  FetchGroceryListByCategory({required this.category});
}
