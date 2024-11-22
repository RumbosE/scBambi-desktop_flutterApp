part of 'child_bloc.dart';

sealed class ChildEvent {
  const ChildEvent();
}

class ChildLoaded extends ChildEvent{
  final Child child;
  ChildLoaded({required this.child});
}

class LoadingStarted extends ChildEvent{}

class ErrorOnChildFetching extends ChildEvent{
  final String errores;
  ErrorOnChildFetching({required this.errores});
}



