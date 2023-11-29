part of 'get_children_bloc.dart';

@immutable
sealed class GetChildrenState {}

final class GetChildrenInitial extends GetChildrenState {}

final class GetChildrenLoading extends GetChildrenState {}

final class GetChildrenSuccess extends GetChildrenState {
  final List<Child> children;

  GetChildrenSuccess(this.children);
}

final class GetChildrenError extends GetChildrenState {
  final String message;

  GetChildrenError(this.message);
}
