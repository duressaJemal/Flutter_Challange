part of 'add_children_bloc.dart';

@immutable
sealed class AddChildrenState {}

final class AddChildrenInitial extends AddChildrenState {}
final class AddChildrenLoading extends AddChildrenState {}
final class AddChildrenSuccess extends AddChildrenState {
  final Child child;
  AddChildrenSuccess(this.child);
}
final class AddChildrenError extends AddChildrenState {
  final String message;

  AddChildrenError(this.message);
}
