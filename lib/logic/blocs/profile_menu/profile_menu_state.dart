import 'package:equatable/equatable.dart';

class ProfileMenuState extends Equatable {
  final bool isLoading;
  final bool isDeleted;
  final String userName;
  final String email;

  const ProfileMenuState({
    required this.isLoading,
    required this.userName,
    required this.email,
    required this.isDeleted,
  });

  factory ProfileMenuState.initial() => const ProfileMenuState(
        isDeleted: false,
        isLoading: false,
        userName: '',
        email: '',
      );

  ProfileMenuState copyWith({
    bool? isLoading,
    bool? isDeleted,
    String? userName,
    String? email,
  }) {
    return ProfileMenuState(
      isDeleted: isDeleted ?? this.isDeleted,
      isLoading: isLoading ?? this.isLoading,
      userName: userName ?? this.userName,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [isDeleted, isLoading, userName, email];
}
