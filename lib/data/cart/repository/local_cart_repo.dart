// import '../../../common/cart_repository.dart';
// import '../../../domain/cart/model/cart_item.dart';
//
// class LocalCartRepository implements CartRepository {
//   final List<CartItem> _cartItems = [];
//
//   @override
//   Future<void> addItemToCart(CartItem item) async {
//     _cartItems.add(item);
//   }
//
//   @override
//   Future<void> removeItemFromCart(String itemId) async {
//     _cartItems.removeWhere((item) => item.id == itemId);
//   }
//
//   @override
//   Future<void> updateItemQuantity(String itemId, int quantity) async {
//     final index = _cartItems.indexWhere((item) => item.id == itemId);
//     if (index != -1) {
//       _cartItems[index] = _cartItems[index].copyWith(quantity: quantity);
//     }
//   }
//
//   @override
//   Stream<List<CartItem>> getCartItems() async* {
//     yield _cartItems;
//   }
// }
