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
