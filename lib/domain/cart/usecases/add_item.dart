import '../../../common/cart_repository.dart';
import '../model/cart_item.dart';

class AddToCart {
  final CartRepository cartRepository;

  AddToCart(this.cartRepository);

  Future<void> execute(CartItem item) async {
    await cartRepository.addItemToCart(item);
  }
}
