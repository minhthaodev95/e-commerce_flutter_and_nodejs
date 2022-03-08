part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {}

// ignore: camel_case_types
class LoginWithEmailAndPassword extends LoginEvent {
  final String email;
  final String password;

  LoginWithEmailAndPassword({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
