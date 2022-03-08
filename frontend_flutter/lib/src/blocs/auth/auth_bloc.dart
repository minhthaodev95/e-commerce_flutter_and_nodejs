import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:frontend_ecommerce_app/src/models/user_model.dart';

import 'package:frontend_ecommerce_app/src/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>(_appStartedToState);
    on<LoggedIn>(_loggedInToState);
    on<LogOut>(_logOutToState);
  }

  void _appStartedToState(AppStarted event, Emitter<AuthState> emit) async {
    final User? user;
    user = await UserRepository().getUser();
    if (user != null) {
      emit(Authorized(user: user));
    } else {
      emit(UnAuthorized());
    }
  }

  void _loggedInToState(LoggedIn event, Emitter<AuthState> emit) async {
    final User? user;
    user = await UserRepository().getUser();
    if (user != null) {
      emit(Authorized(user: user));
    }
  }

  void _logOutToState(LogOut event, Emitter<AuthState> emit) async {
    await UserRepository().logOut();
    emit(UnAuthorized());
  }
}
