import 'package:equatable/equatable.dart';

abstract class ProfileMenuEvent extends Equatable {
  const ProfileMenuEvent();

  @override
  List<Object?> get props => [];
}

class ProfileMenuInitialized extends ProfileMenuEvent {}

class DeleteAccountEvent extends ProfileMenuEvent {}
