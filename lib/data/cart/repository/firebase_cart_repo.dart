import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'cart_repository.dart';
import '../../../domain/cart/model/cart_item.dart';

class FirebaseCartRepository implements CartRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth _firebaseAuth;
  String get userId => _firebaseAuth.currentUser!.uid;
  FirebaseCartRepository(this._firebaseAuth ,this.firestore);

  @override
  Future<void> addItemToCart(CartItem item) async {
    await firestore.collection('users')
        .doc(userId)
        .collection('cart')
        .doc(item.id)
        .set(item.toJson());
  }

  @override
  Future<void> updateItemQuantity(String productId, int quantity) async {
    await firestore .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(productId)
        .update({'quantity': quantity});
  }

  @override
  Future<void> removeItemFromCart(String productId) async {
    await firestore.collection('users')
        .doc(userId)
        .collection('cart')
        .doc(productId)
        .delete();
  }

  @override
  Stream<List<CartItem>> getCartItems() {
    return firestore.collection('users')
        .doc(userId)
        .collection('cart')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return CartItem.fromMap(doc.data());
      }).toList();
    });
  }
}
