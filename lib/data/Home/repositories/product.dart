import '../../../domain/Home/Models/product.dart';

abstract class GroceryRepository {
  Stream<List<Grocery>> fetchGroceries();
  Stream<List<Grocery>> fetchBestSelling();
  Stream<List<Grocery>> fetchNewArrival();
  Stream<List<Grocery>> fetchGroceriesByCategory(String category);
}
