import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sc_flutter_app/domain/child/entities/child.dart';
import 'package:sc_flutter_app/domain/child/repositories/child_repository.dart';
import 'package:sc_flutter_app/presentation/blocs/core/safe_bloc.dart';

part 'child_bloc_event.dart';
part 'child_bloc_state.dart';

class ChildrenBlocBloc extends SafeBloc<ChildrenBlocEvent, ChildrenBlocState> {

  final ChildRepository childRepository;

  ChildrenBlocBloc(this.childRepository) : super(const ChildrenBlocState()) {

    on<ChildrenLoaded>(_onChildrenLoaded);

    on<LoadingStarted>(_onLoadingStarted);

    on<ErrorOnChildrenLoading>(_onErrorOnChildrenLoading);

    on<AllChildrenLoaded>(_onAllChildrenLoaded);

    on<RefreshChildren>(_onRefreshChildren);

  }

  void _onChildrenLoaded(ChildrenLoaded event, Emitter<ChildrenBlocState> emit) {
    emit(
        state.copyWith(
          children: [...state.children, ...event.children],
          status: ChildrenStatus.loaded,
          page: state.page + 1
        )
      );
  }

  void _onLoadingStarted(LoadingStarted event, Emitter<ChildrenBlocState> emit) {
    emit(state.copyWith(status: ChildrenStatus.loading));
  }



  FutureOr<void> _onErrorOnChildrenLoading(ErrorOnChildrenLoading event, Emitter<ChildrenBlocState> emit) {
    emit(state.copyWith(status: ChildrenStatus.error));
  }

  FutureOr<void> _onAllChildrenLoaded(AllChildrenLoaded event, Emitter<ChildrenBlocState> emit) {
    emit(state.copyWith(status: ChildrenStatus.allChildrenLoaded));
  }

  FutureOr<void> _onRefreshChildren(RefreshChildren event, Emitter<ChildrenBlocState> emit) {
    emit(const ChildrenBlocState());
    loadNextPage();
  }
  
  Future<void> loadNextPage() async {

    if (state.status == ChildrenStatus.loading ||
        state.status == ChildrenStatus.allChildrenLoaded) return;
    add(LoadingStarted());

    final res = await childRepository.getChildren();

    if (res.isSuccessful()) {
      final children = res.getValue();
      if (children.isNotEmpty) {
        add(ChildrenLoaded(children: children));
        return;
      }
      add(AllChildrenLoaded());
      return;
    }
    
    add(ErrorOnChildrenLoading());
  }
  
}
