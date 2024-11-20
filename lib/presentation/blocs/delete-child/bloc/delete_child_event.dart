part of 'delete_child_bloc.dart';

class DeleteChildEvent {
  final String id;
  ChildrenBlocBloc? bloc;
  DeleteChildEvent({required this.id, this.bloc});
}

class ChildDeletedSuccess extends DeleteChildEvent {
  ChildDeletedSuccess({required super.id, required super.bloc});
}

class ChildDeletedError extends DeleteChildEvent {
  final String error;

  ChildDeletedError({required this.error, required super.id, required super.bloc});
}

class SnackBarShown extends DeleteChildEvent{
  SnackBarShown(): super(id: '', );
}