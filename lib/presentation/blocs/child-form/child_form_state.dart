part of 'child_form_bloc.dart';

enum FormStatus{ loading, valid, error, initial, validating, submitting, success}

class ChildFormState extends Equatable {

  final String? id;
  final Child child;

  final FormStatus status;
  final String? errors;
  final bool snackBarShown;


  const ChildFormState({this.status = FormStatus.initial, this.errors ,this.id, required this.child, this.snackBarShown = false});
  
  ChildFormState copyWith({
    String? id,
    Child? child,
    FormStatus? status,
    String? errors,
    bool? snackBarShown,
  }) {
    return ChildFormState(
    id: id ?? this.id,
    status: status ?? this.status,
    child: child ?? this.child,
    errors: errors ?? this.errors,
    snackBarShown: snackBarShown ?? this.snackBarShown,
  );}


  @override
  List<Object?> get props => [id, child, status, errors, snackBarShown];
}
