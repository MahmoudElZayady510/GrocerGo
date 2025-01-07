import 'package:groceries/data/cart/repository/cart_repository.dart';

class UpdateCartItemUsecase{
  final CartRepository repository;

  UpdateCartItemUsecase(this.repository);

  Future<void> call (String itemId , int quantity) async{
    return repository.updateItemQuantity(itemId, quantity);
  }
}