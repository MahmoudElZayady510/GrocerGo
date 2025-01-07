import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groceries/data/search/repositories/search_repository.dart';
import 'package:groceries/domain/Home/Models/product.dart';

class FirebaseSearchRepository implements SearchRepository{
  final FirebaseFirestore firestore;

  FirebaseSearchRepository(this.firestore);
  @override
  Future<List<Grocery>> fetchSearchedGroceries(String query) async {
    final lowercasenameQuerySnapshot = await firestore
        .collection('groceries')
        .where('lowercasename', isGreaterThanOrEqualTo: query.toLowerCase())
        .where('lowercasename', isLessThanOrEqualTo: query.toLowerCase() + '\uf8ff')
        .get();

    final categoryQuerySnapshot = await firestore
        .collection('groceries')
        .where('category', isGreaterThanOrEqualTo: query.toLowerCase())
        .where('category', isLessThanOrEqualTo: query.toLowerCase() + '\uf8ff')
        .get();

    final List<Grocery> groceries = [
      ...lowercasenameQuerySnapshot.docs.map((doc) => Grocery.fromMap(doc.data() as Map<String, dynamic>)),
      ...categoryQuerySnapshot.docs.map((doc) => Grocery.fromMap(doc.data() as Map<String, dynamic>)),
    ];

    // Remove duplicates (if any)
    final uniqueGroceries = groceries.toSet().toList();

    return uniqueGroceries;
  }
  // Future<List<Grocery>> fetchSearchedGroceries(String query) async {
  //   final querySnapshot = await firestore
  //       .collection('groceries')
  //       .where('lowercasename', isGreaterThanOrEqualTo: query.toLowerCase())
  //       .where('lowercasename', isLessThanOrEqualTo: query.toLowerCase() + '\uf8ff')
  //       .get();
  //   return querySnapshot.docs
  //       .map((doc) => Grocery.fromMap(doc.data() as Map<String, dynamic>))
  //       .toList();
  // }

}