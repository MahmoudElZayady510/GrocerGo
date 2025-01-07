import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groceries/data/category/repositories/category.dart';
import 'package:groceries/domain/category/models/category.dart';

class FirebaseCategoryRepository implements CategoryRepository{
  
  final FirebaseFirestore firestore;

  FirebaseCategoryRepository(this.firestore);
  @override
  Stream<List<CategoryModel>> fetchCategory() {
    return firestore.collection('categories').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        // print(data);
        return CategoryModel(
          id: doc.id ?? 'noID',
          name: data['name'] ?? 'noname',
          image: data['image'] ?? 'abc',
        );
      }).toList();
    });
  }
  
}