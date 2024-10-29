part of 'child_bloc.dart';

enum ChildDetailsStatus { initial, loading, loaded, error}

class ChildState extends Equatable {

  final Child child;
  final ChildDetailsStatus status;

  const ChildState({
    required this.child,
    this.status = ChildDetailsStatus.initial
  });
  
  ChildState copyWith({
    Child? child,
    ChildDetailsStatus? status,
  }){
    return ChildState(
      child: child?? this.child, 
      status: status ?? this.status
      );
  }

  @override
  List<Object> get props => [child, status];
}
