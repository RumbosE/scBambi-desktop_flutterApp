part of 'child_bloc_bloc.dart';


enum ChildrenStatus { loading, error, initial, loaded,allChildrenLoaded }

class ChildrenBlocState extends Equatable {

  final ChildrenStatus status;
  final List<Child> children;
  final String filter;
  final String? errors;
  final int page;
  final int perPage;

  const ChildrenBlocState({
        this.children = const [],
        this.status = ChildrenStatus.initial,
        this.filter = '',
        this.page = 0,
        this.perPage = 10,
        this.errors
      });

  ChildrenBlocState copyWith({
    ChildrenStatus? status,
    String? filter,
    List<Child>? children,
    int? page,
    int? perPage,
    String? errors
  }) =>
      ChildrenBlocState(
        status: status ?? this.status,
        filter: filter ?? this.filter,
        children: children ?? this.children,
        page: page ?? this.page,
        perPage: perPage ?? this.perPage,
        errors: errors ?? this.errors
      );
  
  @override
  List<Object?> get props => [
    children, status, filter, page, perPage, errors
  ];
}

