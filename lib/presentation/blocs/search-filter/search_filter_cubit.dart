import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bambi_socio_legal_scapp/presentation/blocs/children/child_bloc_bloc.dart';

part 'search_filter_state.dart';

class SearchFilterCubit extends Cubit<SearchFilterState> {

  final ChildrenBlocBloc childrenBloc;

  SearchFilterCubit(this.childrenBloc) : super(const SearchFilterState());

  void onSubmitted() async{
    if (state.filter.isEmpty || state.status == FilterStatus.loading) return;

    emit(state.copyWith(status: FilterStatus.loading));
    childrenBloc.setFilter(state.filter);
    emit(state.copyWith(status: FilterStatus.loaded));
  }

  void setFilterParam(String filter) {
    emit(state.copyWith(filter: filter, status: FilterStatus.loaded));
  }

  void setPage(int page) {
    childrenBloc.setPage(page);
  }
void reset() {
    emit(const SearchFilterState());
    childrenBloc.add(RefreshChildren());
  }

  @override
  Future<void> close() {
    // Limpia el estado aquí si es necesario
    return super.close();
  }
}
