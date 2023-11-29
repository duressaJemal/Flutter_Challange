import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:santas_list/domain/interfaces/child_repository.dart';
import 'package:santas_list/domain/models/child.dart';

part 'get_children_event.dart';
part 'get_children_state.dart';

class GetChildrenBloc extends Bloc<GetChildrenEvent, GetChildrenState> {
  final IChildRepository _childRepository;

  GetChildrenBloc(this._childRepository) : super(GetChildrenInitial()) {
    on<GetChildren>(
      (event, emit) async {
        emit(GetChildrenLoading());
        try {
          final children = _childRepository.getChildren();
          emit(GetChildrenSuccess(children));
        } catch (e) {
          emit(GetChildrenError(e.toString()));
        }
      },
    );
  }
}
