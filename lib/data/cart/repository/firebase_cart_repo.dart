import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../common/cart_repository.dart';
import '../../../domain/cart/model/cart_item.dart';

class FirebaseCartRepository implements CartRepository {
  final FirebaseFirestore firestore;

  FirebaseCartRepository(this.firestore);

  @override
  Future<void> addItemToCart(CartItem item) async {
    await firestore.collection('cart').doc(item.id).set(item.toJson());
  }

  @override
  Future<void> updateItemQuantity(String productId, int quantity) async {
    await firestore.collection('cart').doc(productId).update({
      'quantity': quantity,
    });
  }

  @override
  Future<void> removeItemFromCart(String productId) async {
    await firestore.collection('cart').doc(productId).delete();
  }

  @override
  Stream<List<CartItem>> getCartItems() {
    return firestore.collection('groceriesCart').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => CartItem.fromMap(doc.data())).toList();
    });
  }
}
