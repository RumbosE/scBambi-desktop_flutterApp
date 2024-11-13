part of 'child_form_bloc.dart';

enum FormStatus{ valid, error, initial, validating}

class ChildFormState extends Equatable {

  final String? id;
  final Child child;

  final FormStatus status;
  final String? errors;


  const ChildFormState({this.status = FormStatus.initial, this.errors ,this.id, required this.child});
  
  ChildFormState copyWith({
    String? id,
    Child? child,
    FormStatus? status,
    String? errors,
  }) {
    return ChildFormState(
    id: id ?? this.id,
    status: status ?? this.status,
    child: child ?? this.child,
    errors: errors ?? this.errors
  );}


  @override
  List<Object?> get props => [id, child, status, errors];
}
