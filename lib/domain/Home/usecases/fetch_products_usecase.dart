import '../../../data/Home/repositories/product.dart';
import '../Models/product.dart';

class FetchGroceries {
  final GroceryRepository repository;

  FetchGroceries(this.repository);

  Stream<List<Grocery>> call() {
    return repository.fetchGroceries();
  }
}

