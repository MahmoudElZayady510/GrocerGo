part of 'cart_bloc.dart';

abstract class CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> cartItems;

  CartLoaded(this.cartItems);
}
class CartError extends CartState{
  final String error;
  CartError(this.error);
}