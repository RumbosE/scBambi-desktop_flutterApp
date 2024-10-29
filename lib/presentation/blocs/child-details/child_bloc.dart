import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sc_flutter_app/domain/child/entities/child.dart';
import 'package:sc_flutter_app/domain/child/repositories/child_repository.dart';

part 'child_event.dart';
part 'child_state.dart';

final initialState = Child(id: '',name: '', lastName: '',foundationId: '', personalId: '', birthDate: '', history: FoundationHistory(), responsible: Responsible());


class ChildBloc extends Bloc<ChildEvent, ChildState> {

  final ChildRepository childRepository;

  ChildBloc(this.childRepository) 
    : super(ChildState(child: initialState)) {
      on<ChildLoaded>(_onChildLoaded);
      on<LoadingStarted>(_onLoadingStarted);
      on<ErrorOnChildLoading>(_onErrorOnChildLoading);
  }

  void _onChildLoaded(ChildLoaded event, Emitter<ChildState> emit) {
    emit(state.copyWith(child: event.child, status: ChildDetailsStatus.loaded));
  }

  void _onLoadingStarted(LoadingStarted event, Emitter<ChildState> emit) {
    emit(state.copyWith(status: ChildDetailsStatus.loading));
  }

  void _onErrorOnChildLoading(
      ErrorOnChildLoading event, Emitter<ChildState> emit) {
    emit(state.copyWith(status: ChildDetailsStatus.error));
  }

  Future<void> loadChildById(String childId) async{

    if (state.status == ChildDetailsStatus.loading) return;
    add(LoadingStarted());

    final childResponse = await childRepository.getChild(childId);

    if (childResponse.isSuccessful()) {
      final child = childResponse.getValue();

      add(ChildLoaded(child: child));
      return;
    }
    add(ErrorOnChildLoading());
  }
}
