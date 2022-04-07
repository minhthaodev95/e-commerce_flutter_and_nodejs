import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'load_category_event.dart';
part 'load_category_state.dart';

class LoadCategoryBloc extends Bloc<LoadCategoryEvent, LoadCategoryState> {
  LoadCategoryBloc() : super(LoadCategoryInitial()) {
    on<LoadCategoryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
