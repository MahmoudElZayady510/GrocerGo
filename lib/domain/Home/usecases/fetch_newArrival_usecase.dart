import '../../../data/Home/repositories/product.dart';
import '../Models/product.dart';

class FetchNewArrivalUsecase {
  final GroceryRepository repository;

  FetchNewArrivalUsecase(this.repository);

  Stream<List<Grocery>> call() {
    return repository.fetchNewArrival();
  }
}
