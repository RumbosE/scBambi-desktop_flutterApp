part of 'child_bloc_bloc.dart';


enum ChildrenStatus { loading, error, loaded, allChildrenLoaded }

class ChildrenBlocState extends Equatable {

  final ChildrenStatus status;
  final List<Child> children;
  final int page;
  final int perPage;

  const ChildrenBlocState({
        this.children = const [],
        this.status = ChildrenStatus.loaded,
        this.page = 1,
        this.perPage = 10
      });

  ChildrenBlocState copyWith({
    ChildrenStatus? status,
    List<Child>? children,
    int? page,
    int? perPage,
  }) =>
      ChildrenBlocState(
        status: status ?? this.status,
        children: children ?? this.children,
        page: page ?? this.page,
        perPage: perPage ?? this.perPage,
      );
  
  @override
  List<Object> get props => [
    children, status
  ];
}

