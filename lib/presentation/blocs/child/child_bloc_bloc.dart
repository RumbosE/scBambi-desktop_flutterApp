import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'child_bloc_event.dart';
part 'child_bloc_state.dart';

class ChildBlocBloc extends Bloc<ChildBlocEvent, ChildBlocState> {
  ChildBlocBloc() : super(ChildBlocInitial()) {
    on<ChildBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
