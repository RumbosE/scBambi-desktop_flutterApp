part of 'child_bloc.dart';

enum ChildDetailsStatus { initial, loading, loaded, error}

class ChildState extends Equatable {

  final Child child;
  final ChildDetailsStatus status;
  final String? errors;

  const ChildState({
    required this.child,
    this.status = ChildDetailsStatus.initial,
    this.errors
  });
  
  ChildState copyWith({
    Child? child,
    ChildDetailsStatus? status,
    String? errors,
  }){
    return ChildState(
      child: child?? this.child, 
      status: status ?? this.status,
      errors: errors ?? this.errors
      );
  }

  @override
  List<Object?> get props => [child, status, errors];
}
