import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:santas_list/domain/interfaces/child_repository.dart';
import 'package:santas_list/domain/models/child.dart';

part 'add_children_event.dart';
part 'add_children_state.dart';

class AddChildrenBloc extends Bloc<AddChildrenEvent, AddChildrenState> {
  final IChildRepository childRepository;
  AddChildrenBloc(this.childRepository) : super(AddChildrenInitial()) {
    on<AddChildren>((event, emit) {
      emit(AddChildrenLoading());
      sleep(const Duration(seconds: 2));
      try {
        childRepository.addChild(event.child);
        emit(AddChildrenSuccess(event.child));
      } catch (e) {
        emit(AddChildrenError(e.toString()));
      }
    });
  }
}
