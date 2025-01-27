import 'package:kidame_gebiya/features/cart/data/models/cart_model.dart';

abstract class CartState {}

class CartInitial extends CartState{}
class CartLoading extends CartState{}
class CartLoaded extends CartState{
  final List<CartModel> userCarts;

  CartLoaded({required this.userCarts});
}
class CartError extends CartState{
  final String error;

  CartError({required this.error});
}