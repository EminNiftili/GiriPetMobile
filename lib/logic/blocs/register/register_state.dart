import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String phone;
  final bool isLoading;
  final String errorMessage;

  const RegisterState({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phone,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    required this.isLoading,
    required this.errorMessage,
  });

  factory RegisterState.initial() => const RegisterState(
        name: '',
        email: '',
        password: '',
        confirmPassword: '',
        phone: '',
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        isLoading: false,
        errorMessage: '',
      );

  RegisterState copyWith(
      {String? name,
      String? email,
      String? password,
      String? confirmPassword,
      String? phone,
      bool? isSubmitting,
      bool? isSuccess,
      bool? isFailure,
      bool? isLoading,
      String? errorMessage}) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      phone: phone ?? this.phone,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        name,
        email,
        password,
        confirmPassword,
        phone,
        isSubmitting,
        isSuccess,
        isFailure,
        isLoading,
        errorMessage,
      ];
}
