import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend_ecommerce_app/src/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.empty()) {
    on<LoginWithEmailAndPassword>(_loginWithEmailAndPassword);
  }

  void _loginWithEmailAndPassword(
      LoginWithEmailAndPassword event, Emitter<LoginState> emit) async {
    emit(LoginState.loading());
    try {
      String? id = await UserRepository()
          .signInWithEmailandPassword(event.email, event.password);
      print('id : $id');
      if (id != null) {
        emit(LoginState.success());
      } else {
        print('emit failure');
        emit(LoginState.failure());
      }
    } catch (_) {
      print('emit catch error failure');
      print(_);
      emit(LoginState.failure());
    }
  }
}
