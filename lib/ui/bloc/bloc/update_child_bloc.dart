import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:santas_list/domain/interfaces/child_repository.dart';
import 'package:santas_list/domain/models/child.dart';

part 'update_child_event.dart';
part 'update_child_state.dart';

class UpdateChildBloc extends Bloc<UpdateChildEvent, UpdateChildState> {
  final IChildRepository childRepository;
  UpdateChildBloc(this.childRepository) : super(UpdateChildInitial()) {
    on<UpdateChild>((event, emit) {
      emit(UpdateChildLoading());
      try {
        childRepository.updateChild(event.child);
        emit(UpdateChildSuccess());
      } catch (e) {
        emit(UpdateChildFailure(e.toString()));
      }
    });
  }
}
