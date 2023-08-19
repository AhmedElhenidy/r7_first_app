part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class ChangeCurrentIndexState extends HomeState {
  final int index;
 const ChangeCurrentIndexState(this.index);
  @override
  List<Object> get props => [index];
}
