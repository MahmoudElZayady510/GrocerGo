import '../../../domain/Home/Models/product.dart';

abstract class GroceryRepository {
  Stream<List<Grocery>> fetchGroceries();
}
