part of 'categories_bloc.dart';

class CategoriesState {}

final class CategoriesLoading extends CategoriesState {}

final class CategoriesLoaded extends CategoriesState{
  final List<CategoryModel> categories;
  final String selectedCategory;
  CategoriesLoaded(this.categories ,this.selectedCategory);
}
// final class SelectedCategory extends CategoriesState{
//   final String selectedCategory;
//
//   SelectedCategory({required this.selectedCategory});
// }
final class CategoriesError extends CategoriesState{
  final String message;

  CategoriesError(this.message);
}
