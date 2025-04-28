import 'package:equatable/equatable.dart';

class ProfileMenuState extends Equatable {
  final bool isLoading;
  final String userName;
  final String email;

  const ProfileMenuState({
    required this.isLoading,
    required this.userName,
    required this.email,
  });

  factory ProfileMenuState.initial() => const ProfileMenuState(
        isLoading: false,
        userName: '',
        email: '',
      );

  ProfileMenuState copyWith({
    bool? isLoading,
    String? userName,
    String? email,
  }) {
    return ProfileMenuState(
      isLoading: isLoading ?? this.isLoading,
      userName: userName ?? this.userName,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [isLoading, userName, email];
}
