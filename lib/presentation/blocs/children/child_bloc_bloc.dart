import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sc_flutter_app/domain/child/entities/child.dart';
import 'package:sc_flutter_app/domain/child/repositories/child_repository.dart';
import 'package:sc_flutter_app/presentation/blocs/core/safe_bloc.dart';

part 'child_bloc_event.dart';
part 'child_bloc_state.dart';

class ChildrenBlocBloc extends SafeBloc<ChildrenBlocEvent, ChildrenBlocState> {

  final IChildRepository childRepository;

  ChildrenBlocBloc(this.childRepository) : super(const ChildrenBlocState()) {

    on<ChildrenLoaded>(_onChildrenLoaded);

    on<LoadingStarted>(_onLoadingStarted);

    on<ErrorOnChildrenLoading>(_onErrorOnChildrenLoading);

    on<AllChildrenLoaded>(_onAllChildrenLoaded);

    on<RefreshChildren>(_onRefreshChildren);

    on<FilterSetChildren>(onFilterSetChildren);

    on<PageChanged>(onPageChanged);

  }

  void _onChildrenLoaded(ChildrenLoaded event, Emitter<ChildrenBlocState> emit) {
    emit(
        state.copyWith(
          children: [...event.children],
          status: ChildrenStatus.loaded,
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
    fetchChildrenPaginated();
  }

  FutureOr<void> onFilterSetChildren(FilterSetChildren event, Emitter<ChildrenBlocState> emit) {
    emit(state.copyWith(filter: event.filter, children: [], page: 0, status: ChildrenStatus.initial));
    fetchChildrenPaginated();
  }

  FutureOr<void> onPageChanged(PageChanged event, Emitter<ChildrenBlocState> emit) {
    emit(state.copyWith(page: event.page, children: []));
    fetchChildrenPaginated();
  }

  void setFilter(String filter) {
    add(FilterSetChildren(filter: filter));
  }

  void setPage(int pag) {
    add(PageChanged(page: pag));
  }
  
  Future<void> fetchChildrenPaginated() async {
    if (state.status == ChildrenStatus.loading ||
    state.filter == '' || 
    state.status == ChildrenStatus.error) return;

    add(LoadingStarted());
    
    final res = await childRepository.getChildren(
      state.filter, 
      state.page, 
      state.perPage
    );

    if (res.isSuccessful()){
      final children = res.getValue();
      if (children.isEmpty){
        add(AllChildrenLoaded());
      } else {
        add(ChildrenLoaded(children: children));
      }
    }else {
      add(ErrorOnChildrenLoading());
    }
  
  }
}