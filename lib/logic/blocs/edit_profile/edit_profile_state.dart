import 'package:equatable/equatable.dart';

class EditProfileState extends Equatable {
  final bool isFailure;
  final bool isSuccess;
  final bool isLoading;
  final bool isEditing;
  final String name;
  final String email;
  final String phone;

  const EditProfileState({
    required this.isFailure,
    required this.isSuccess,
    required this.isLoading,
    required this.isEditing,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory EditProfileState.initial() => EditProfileState(
        isFailure: false,
        isSuccess: false,
        isLoading: false,
        isEditing: false,
        name: '',
        email: '',
        phone: '',
      );

  EditProfileState copyWith({
    bool? isFailure,
    bool? isSuccess,
    bool? isLoading,
    bool? isEditing,
    String? name,
    String? email,
    String? phone,
  }) {
    return EditProfileState(
      isFailure: isFailure ?? this.isFailure,
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
      isEditing: isEditing ?? this.isEditing,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  @override
  List<Object?> get props =>
      [isFailure, isSuccess, isLoading, isEditing, name, email, phone];
}
