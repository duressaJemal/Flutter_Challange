part of 'update_child_bloc.dart';

@immutable
sealed class UpdateChildState {}

final class UpdateChildInitial extends UpdateChildState {}
final class UpdateChildLoading extends UpdateChildState {}
final class UpdateChildSuccess extends UpdateChildState {}
final class UpdateChildFailure extends UpdateChildState {
  final String message;
  UpdateChildFailure(this.message);
}
