import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/firebase_authentication_srevice.dart';
import '../../screens/home_screen.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void singIn(String email,String password,BuildContext context){
    if(email.isEmpty||password.isEmpty){
      emit(AuthErrorState("Please enter correct Data"));
    }else{
      emit(AuthLoadingState());
      FirebaseAuthenticationService.signIn(
        email: email,
        password: password,
      ).then(
              (credential){
           emit(AuthSuccess());
          },
          onError: (error){
            if(error is FirebaseAuthException){
              emit(AuthErrorState(error.code));
            }else{
              emit(AuthErrorState(error.toString()));
            }

          }
      );
    }
  }
}
