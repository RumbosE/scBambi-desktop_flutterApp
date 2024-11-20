part of 'child_bloc_bloc.dart';

sealed class ChildrenBlocEvent {
  const ChildrenBlocEvent();
}

class ChildrenLoaded extends ChildrenBlocEvent {

  final List<Child> children;
  const ChildrenLoaded({required this.children});
  
}

class FilterSetChildren extends ChildrenBlocEvent {
  final String filter;
  const FilterSetChildren({required this.filter});
}

class PageChanged extends ChildrenBlocEvent {
  final int page;
  const PageChanged({required this.page});
}

class AllChildrenLoaded extends ChildrenBlocEvent {}

class LoadingStarted extends ChildrenBlocEvent {}

class ErrorOnChildrenLoading extends ChildrenBlocEvent {}

class RefreshChildren extends ChildrenBlocEvent {}
