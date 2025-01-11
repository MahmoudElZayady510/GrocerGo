import '../../../data/Home/repositories/product.dart';
import '../Models/product.dart';

class FetchBestsellingUsecase {
  final GroceryRepository repository;

  FetchBestsellingUsecase(this.repository);

  Stream<List<Grocery>> call() {
    return repository.fetchBestSelling();
  }
}
