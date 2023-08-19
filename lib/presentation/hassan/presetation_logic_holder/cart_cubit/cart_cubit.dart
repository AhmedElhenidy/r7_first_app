import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  List<QueryDocumentSnapshot<Map<String,dynamic>>> cartItems=[];

  Future<void> getCartItems()async{
    emit(CartItemLoadingState());
    FirebaseFirestore.instance.collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid).collection("cart").get().then((value){
      cartItems=value.docs;
      emit(CartInitial());
    },
      onError: (error){
          emit(CartItemErrorState(error.toString()));
      },
    );
  }

  num  getTotalCost(){
    num total = 0;
    cartItems.forEach((element) {
      total+=( element['price'] as num )*( element['quantity'] as num );
    });
    return total;
  }
}
