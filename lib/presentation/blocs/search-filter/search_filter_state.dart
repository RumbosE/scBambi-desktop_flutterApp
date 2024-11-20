part of 'search_filter_cubit.dart';

enum FilterStatus { initial, loading, loaded, error }
class SearchFilterState extends Equatable{

    final String filter;
    final FilterStatus status;


    const SearchFilterState({
      this.filter = '',
      this.status = FilterStatus.initial,  
    });

    SearchFilterState copyWith({
        String? filter,
        FilterStatus? status,
    }) {
        return SearchFilterState(
            filter: filter ?? this.filter,
            status: status ?? this.status,
        );}

    @override
    List<Object> get props =>  [filter, status];
}
