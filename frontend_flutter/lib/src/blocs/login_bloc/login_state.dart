part of 'login_bloc.dart';

@immutable
class LoginState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  const LoginState(
      {required this.isEmailValid,
      required this.isFailure,
      required this.isPasswordValid,
      required this.isSubmitting,
      required this.isSuccess});

  factory LoginState.empty() {
    return const LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isFailure: false,
        isSubmitting: false,
        isSuccess: false);
  }
  factory LoginState.loading() {
    return const LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isFailure: false,
        isSubmitting: true,
        isSuccess: false);
  }
  factory LoginState.success() {
    return const LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isFailure: false,
        isSubmitting: false,
        isSuccess: true);
  }
  factory LoginState.failure() {
    return const LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isFailure: true,
        isSubmitting: false,
        isSuccess: false);
  }
}
