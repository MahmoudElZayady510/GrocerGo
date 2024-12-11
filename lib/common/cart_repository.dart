import '../domain/cart/model/cart_item.dart';

abstract class CartRepository {
  Future<void> addItemToCart(CartItem item);
  Future<void> removeItemFromCart(String itemId);
  Future<void> updateItemQuantity(String itemId, int quantity);
  Stream<List<CartItem>> getCartItems();
}
