import 'package:groceries/domain/Home/Models/product.dart';

abstract class SearchRepository{
  Future<List<Grocery>> fetchSearchedGroceries(String query);
}