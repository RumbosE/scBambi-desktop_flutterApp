part of 'search_filter_cubit.dart';


class SearchFilterState extends Equatable{

    final String name;
    final DateTime? startDate;
    final DateTime endDate;
    final String nroExp;


    SearchFilterState({
        this.name = '',
        this.startDate,
        DateTime? endDate,
        this.nroExp = '',
    }) : endDate = endDate ?? DateTime.now();

    SearchFilterState copyWith({
        String? name,
        DateTime? startDate,
        DateTime? endDate,
        String? nroExp,
    }) {
        return SearchFilterState(
            name: name ?? this.name,
            startDate: startDate ?? this.startDate,
            endDate: endDate ?? this.endDate,
            nroExp: nroExp ?? this.nroExp,
        );
    }

    @override
    List<Object> get props =>  [name, startDate ?? DateTime(1970, 1, 1), endDate, nroExp];
}
