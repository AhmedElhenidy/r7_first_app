part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

class CartItemLoadingState extends CartState {
  @override
  List<Object> get props => [];
}

class CartItemErrorState extends CartState {
  final String errMsg;
  const CartItemErrorState(this.errMsg);
  @override
  List<Object> get props => [errMsg];
}
