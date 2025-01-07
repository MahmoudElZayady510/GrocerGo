import '../../../data/cart/repository/cart_repository.dart';
import '../model/cart_item.dart';

class AddToCartUsecase {
  final CartRepository cartRepository;

  AddToCartUsecase(this.cartRepository);

  Future<void> call(CartItem item) async {
    await cartRepository.addItemToCart(item);
  }
}
