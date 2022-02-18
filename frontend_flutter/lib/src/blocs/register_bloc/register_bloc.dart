import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend_ecommerce_app/src/models/user_register_model.dart';
import 'package:frontend_ecommerce_app/src/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState.empty()) {
    on<RegisterWithEmailAndPassword>(_registerWithEmailAndPassword);
  }

  void _registerWithEmailAndPassword(
      RegisterWithEmailAndPassword event, Emitter<RegisterState> emit) async {
    emit(RegisterState.loading());
    try {
      int? isRegistered =
          await UserRepository().registerWithEmailandPassword(event.user);

      switch (isRegistered) {
        case 203:
          emit(RegisterState.isExist());
          break;
        case 200:
          emit(RegisterState.success());
          break;
        default:
      }
    } catch (e) {
      emit(RegisterState.failure());
    }
  }
}
