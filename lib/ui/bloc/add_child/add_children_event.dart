part of 'add_children_bloc.dart';

@immutable
sealed class AddChildrenEvent {}

final class AddChildren extends AddChildrenEvent {
  final Child child;
  AddChildren(this.child);
}
