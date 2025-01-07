part of 'categories_bloc.dart';

class CategoriesEvent {}
class FetchCategoryList extends CategoriesEvent{}
class SelectCategory extends CategoriesEvent{
  final String currentCategory;

  SelectCategory({
    required this.currentCategory
});
}
