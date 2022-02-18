part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class UnAuthorized extends AuthState {
  @override
  List<Object?> get props => [];
}

class Authorized extends AuthState {
  final User user;
  Authorized({required this.user});

  @override
  List<Object?> get props => [user];
}
