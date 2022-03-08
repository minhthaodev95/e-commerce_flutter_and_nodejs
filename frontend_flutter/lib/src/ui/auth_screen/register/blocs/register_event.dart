part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent extends Equatable {}

class RegisterWithEmailAndPassword extends RegisterEvent {
  final UserRegister user;

  RegisterWithEmailAndPassword({required this.user});

  @override
  List<Object> get props => [user];
}
