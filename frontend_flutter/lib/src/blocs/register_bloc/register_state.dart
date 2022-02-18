part of 'register_bloc.dart';

@immutable
class RegisterState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool isExists;

  const RegisterState(
      {required this.isEmailValid,
      required this.isFailure,
      required this.isExists,
      required this.isPasswordValid,
      required this.isSubmitting,
      required this.isSuccess});

  factory RegisterState.empty() {
    return const RegisterState(
        isEmailValid: true,
        isPasswordValid: true,
        isExists: false,
        isFailure: false,
        isSubmitting: false,
        isSuccess: false);
  }
  factory RegisterState.loading() {
    return const RegisterState(
        isEmailValid: true,
        isPasswordValid: true,
        isExists: false,
        isFailure: false,
        isSubmitting: true,
        isSuccess: false);
  }
  factory RegisterState.success() {
    return const RegisterState(
        isEmailValid: true,
        isPasswordValid: true,
        isExists: false,
        isFailure: false,
        isSubmitting: false,
        isSuccess: true);
  }
  factory RegisterState.failure() {
    return const RegisterState(
        isEmailValid: true,
        isPasswordValid: true,
        isFailure: true,
        isExists: false,
        isSubmitting: false,
        isSuccess: false);
  }
  factory RegisterState.isExist() {
    return const RegisterState(
        isEmailValid: true,
        isPasswordValid: true,
        isFailure: false,
        isExists: true,
        isSubmitting: false,
        isSuccess: false);
  }
}
