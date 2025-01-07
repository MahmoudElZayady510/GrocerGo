import '../../../data/cart/repository/cart_repository.dart';
import '../model/cart_item.dart';

class FetchCartItemsUseCase {
  final CartRepository repository;

  FetchCartItemsUseCase(this.repository);

  Stream<List<CartItem>> call() {
    return repository.getCartItems();
  }
}
