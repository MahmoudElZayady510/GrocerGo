import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../common/cart_repository.dart';
import '../../../domain/cart/model/cart_item.dart';
import '../../../domain/cart/usecases/fetch_items.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository repository;

  CartBloc(this.repository) : super(CartLoading()) {
    on<AddItemEvent>((event, emit) async {
      await repository.addItemToCart(event.item);
    });

    on<RemoveItemEvent>((event, emit) async {
      await repository.removeItemFromCart(event.itemId);
    });

    on<FetchCartItemsEvent>((event, emit) async {
      emit(CartLoading());
      await emit.forEach<List<CartItem>>(
        repository.getCartItems(), // The stream of data
        onData: (items) => CartLoaded(items), // State when new data arrives
        onError: (_, __) => CartError('Failed to fetch cart items'), // State on error
      );
    });

  }
}

