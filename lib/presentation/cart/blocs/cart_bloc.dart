
import 'package:bloc/bloc.dart';
import 'package:groceries/domain/cart/usecases/add_item.dart';
import 'package:groceries/domain/cart/usecases/remove_cart_item.dart';
import 'package:groceries/domain/cart/usecases/update_cart_item.dart';
import 'package:meta/meta.dart';

import '../../../data/cart/repository/cart_repository.dart';
import '../../../domain/cart/model/cart_item.dart';
import '../../../domain/cart/usecases/fetch_items.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCartUsecase addToCartUsecase;
  final FetchCartItemsUseCase fetchCartItemsUseCase;
  final RemoveFromCartUsecase removeFromCartUsecase;
  final UpdateCartItemUsecase updateCartItemUsecase;

  CartBloc(this.addToCartUsecase, this.fetchCartItemsUseCase, this.removeFromCartUsecase, this.updateCartItemUsecase) : super(CartLoading()) {
    on<AddItemEvent>((event, emit) async {
      await addToCartUsecase.call(event.item);
    });

    on<UpdateItemEvent>((event, emit) async {
      await updateCartItemUsecase.call(event.itemId , event.quantity);
    });

    on<RemoveItemEvent>((event, emit) async {
      await removeFromCartUsecase.call(event.itemId);
    });

    on<FetchCartItemsEvent>((event, emit) async {
      emit(CartLoading());
      await emit.forEach<List<CartItem>>(
        fetchCartItemsUseCase.call(), // The stream of data
        onData: (items) => CartLoaded(items), // State when new data arrives
        onError: (_, __) => CartError('Failed to fetch cart items'), // State on error
      );
    });

  }
}

