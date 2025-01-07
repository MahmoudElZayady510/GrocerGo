import '../../../domain/Home/Models/product.dart';

abstract class GroceryRepository {
  Stream<List<Grocery>> fetchGroceries();
  Stream<List<Grocery>> fetchGroceriesByCategory(String category);
}
