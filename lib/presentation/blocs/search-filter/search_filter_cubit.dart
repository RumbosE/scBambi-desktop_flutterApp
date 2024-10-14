import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_filter_state.dart';

class SearchFilterCubit extends Cubit<SearchFilterState> {
  SearchFilterCubit() : super(SearchFilterState());

  void onSubmitted() {
    print('State: $state');
  }

  void setName(String name) {
    emit(state.copyWith(name: name));
  }

  void setStartDate(DateTime startDate) {
    emit(state.copyWith(startDate: startDate));
  }

  void setEndDate(DateTime endDate) {
    emit(state.copyWith(endDate: endDate));
  }

  void setNroExp(String nroExp) {
    emit(state.copyWith(nroExp: nroExp));
  }

  void clear() {
    emit( SearchFilterState());
  }
}
