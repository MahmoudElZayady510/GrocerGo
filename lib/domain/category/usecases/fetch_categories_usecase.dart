import 'package:groceries/data/category/repositories/category.dart';
import 'package:groceries/domain/category/models/category.dart';

class FetchCategories{
  final CategoryRepository repository;

  FetchCategories(this.repository);

  Stream<List<CategoryModel>> call(){
    return repository.fetchCategory();
  }
}