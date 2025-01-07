import '../../../data/Home/repositories/product.dart';
import '../Models/product.dart';

class FetchGroceriesByCategoryUsecase {
  final GroceryRepository repository;

  FetchGroceriesByCategoryUsecase(this.repository);

  Stream<List<Grocery>> call(String category) {
    return repository.fetchGroceriesByCategory(category);
  }
}