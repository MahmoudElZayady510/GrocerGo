import '../../../data/Home/repositories/product.dart';
import '../Models/product.dart';

class FetchGroceriesUsecase {
  final GroceryRepository repository;

  FetchGroceriesUsecase(this.repository);

  Stream<List<Grocery>> call() {
    return repository.fetchGroceries();
  }
}

