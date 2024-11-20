import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sc_flutter_app/domain/child/repositories/child_repository.dart';
import 'package:sc_flutter_app/presentation/blocs/children/child_bloc_bloc.dart';

part 'delete_child_event.dart';
part 'delete_child_state.dart';

class DeleteChildBloc extends Bloc<DeleteChildEvent, DeleteChildState> {

  final IChildRepository childRepository;

  DeleteChildBloc(this.childRepository) : super(const DeleteChildInitial()) {
    on<DeleteChildEvent>((event, emit) async {
      if (state.status == DeleteStatus.loading) return;
      emit(state.copyWith(status: DeleteStatus.loading, snackBarShown: false));
      final res = await childRepository.deleteChild(event.id);
      if (res.isSuccessful()){
        emit(state.copyWith(status: DeleteStatus.success));
        if(event.bloc != null) event.bloc!.add(RefreshChildren());
      } else {
        emit(state.copyWith(status: DeleteStatus.error, error: res.getError().toString()));
      }
    });

    on<SnackBarShown>((event, emit){
      emit(state.copyWith(snackBarShown: true));
    });
  }
}
