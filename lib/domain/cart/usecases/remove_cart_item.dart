import 'package:groceries/data/cart/repository/cart_repository.dart';
import 'package:groceries/domain/cart/model/cart_item.dart';

class RemoveFromCartUsecase{
final CartRepository repository;

  RemoveFromCartUsecase(this.repository);

  Future<void> call(String itemId) async{
    return repository.removeItemFromCart(itemId);
}
}