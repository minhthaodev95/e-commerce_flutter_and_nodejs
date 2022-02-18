part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {}

class AppStarted extends AuthEvent {
  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthEvent {
  @override
  List<Object> get props => [];
}

class LogOut extends AuthEvent {
  @override
  List<Object> get props => [];
}
