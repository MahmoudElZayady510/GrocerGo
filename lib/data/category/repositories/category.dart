import 'package:groceries/domain/category/models/category.dart';

abstract class CategoryRepository{
  Stream<List<CategoryModel>> fetchCategory();
}