part of 'cart_bloc.dart';

abstract class CartEvent {}

class AddItemEvent extends CartEvent {
  final CartItem item;

  AddItemEvent(this.item);
}
class UpdateItemEvent extends CartEvent{
  final String itemId;
  final int quantity;

  UpdateItemEvent(this.itemId, this.quantity);
}
class RemoveItemEvent extends CartEvent {
  final String itemId;

  RemoveItemEvent(this.itemId);
}

class FetchCartItemsEvent extends CartEvent{}
