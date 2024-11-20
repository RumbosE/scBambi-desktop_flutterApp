part of 'delete_child_bloc.dart';

enum DeleteStatus { initial, loading, success, error }

class DeleteChildState extends Equatable {

  final DeleteStatus status;
  final String? error;
  final bool snackBarShown;

  const DeleteChildState({ this.snackBarShown = false ,this.status=DeleteStatus.initial, this.error});

  DeleteChildState copyWith({
    DeleteStatus? status,
    String? error,
    bool? snackBarShown
  }) {
    return DeleteChildState(
      status: status ?? this.status,
      error: error ?? this.error,
      snackBarShown: snackBarShown ?? this.snackBarShown
    );
  }
  
  @override
  List<Object?> get props => [
    status,
    error,
    snackBarShown
  ];
}

class DeleteChildInitial extends DeleteChildState {
  const DeleteChildInitial();
}