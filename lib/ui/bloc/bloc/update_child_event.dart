part of 'update_child_bloc.dart';

@immutable
sealed class UpdateChildEvent {}
final class UpdateChild extends UpdateChildEvent {
  final Child child;
  UpdateChild(this.child);
}

