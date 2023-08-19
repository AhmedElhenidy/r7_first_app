import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  int current = 0;
  void changeCurrentIndex(int index){
    current=index;
    emit(ChangeCurrentIndexState(index));
  }
}
