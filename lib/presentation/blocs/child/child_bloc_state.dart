part of 'child_bloc_bloc.dart';

sealed class ChildBlocState extends Equatable {
  const ChildBlocState();
  
  @override
  List<Object> get props => [];
}

final class ChildBlocInitial extends ChildBlocState {}
