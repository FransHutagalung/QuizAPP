import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'content_preparation_event.dart';
part 'content_preparation_state.dart';

class ContentPreparationBloc extends Bloc<ContentPreparationEvent, ContentPreparationState> {
  ContentPreparationBloc() : super(ContentPreparationInitial()) {
    on<ContentPreparationEvent>((event, emit) {
     
    });
    on<SetAge>((event , emit) {
      emit(AgePicker(event.picker));
    });
  }
}
