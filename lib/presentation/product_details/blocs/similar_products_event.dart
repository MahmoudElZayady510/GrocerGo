part of 'similar_products_bloc.dart';

class SimilarProductsEvent {}
final class FetchSimilarProducts extends SimilarProductsEvent{
  final String category;

  FetchSimilarProducts({required this.category});

}
