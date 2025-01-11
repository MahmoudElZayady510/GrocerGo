import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groceries/data/Home/repositories/product.dart';

import '../../../domain/Home/Models/product.dart';

class FirebaseGroceryRepository implements GroceryRepository {
  final FirebaseFirestore firestore;

  FirebaseGroceryRepository(this.firestore);


  @override
  Stream<List<Grocery>> fetchGroceries() {
    return firestore.collection('groceries').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        // print(data);
        return Grocery(
          id: doc.id,
          name: data['name'] ?? 'noname',
          price: data['price'] ?? 999999,
          image: data['image'] ?? 'abc',
            description: data['description'] ?? 'no desc',
          category: data['category'] ?? 'noCat',
          unit: data['unit'] ?? 'Unit'
        );
      }).toList();
    });
  }
  @override
  Stream<List<Grocery>> fetchBestSelling() {
    return firestore.collection('bestSellings').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        // print(data);
        return Grocery(
            id: doc.id,
            name: data['name'] ?? 'noname',
            price: data['price'] ?? 999999,
            image: data['image'] ?? 'abc',
            description: data['description'] ?? 'no desc',
            category: data['category'] ?? 'noCat',
          unit: data['unit'] ?? 'Unit'
            //Todo add unit field in newArrival and bestSelling collections
        );
      }).toList();
    });
  }
  @override
  Stream<List<Grocery>> fetchNewArrival() {
    return firestore.collection('newArrival').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        // print(data);
        return Grocery(
            id: doc.id,
            name: data['name'] ?? 'noname',
            price: data['price'] ?? 999999,
            image: data['image'] ?? 'abc',
            description: data['description'] ?? 'no desc',
            category: data['category'] ?? 'noCat',
            unit: data['unit'] ?? 'Unit'
        );
      }).toList();
    });
  }
  @override
  Stream<List<Grocery>> fetchGroceriesByCategory(String category) {
    return firestore.collection('groceries').where('category' , isEqualTo: category).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        // print(data);
        return Grocery(
          id: doc.id,
          name: data['name'] ?? 'noname',
          price: data['price'] ?? 999999,
          image: data['image'] ?? 'abc',
          description: data['description'] ?? 'no desc',
          category: data['category'] ?? 'noCat',
            unit: data['unit'] ?? 'noUnit'
        );
      }).toList();
    });
  }


  // @override
  // Future<List<Grocery>> fetchGroceries() async {
  //   final snapshot = await firestore.collection('groceries').get();
  //   return snapshot.docs.map((doc) {
  //     final data = doc.data();
  //     return Grocery(
  //       id: doc.id,
  //       name: data['name'],
  //       price: (data['price'] as num).toDouble(),
  //       imageUrl: data['imageUrl'],
  //       description: data['description'],
  //     );
  //   }).toList();
  // }
}
