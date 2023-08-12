part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}
class AuthLoadingState extends AuthState {
  @override
  List<Object> get props => [];
}
class AuthErrorState extends AuthState {
  final String msg;
  const AuthErrorState(this.msg);
  @override
  List<Object> get props => [msg];
}

class AuthSuccess extends AuthState {
  @override
  List<Object> get props => [];
}
