import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giripet_mobile/data/datasources/user_datasource.dart';
import 'package:giripet_mobile/data/models/user.dart';
import 'profile_menu_event.dart';
import 'profile_menu_state.dart';

class ProfileMenuBloc extends Bloc<ProfileMenuEvent, ProfileMenuState> {
  late UserDataSource _userDataSource;
  late User? user;
  ProfileMenuBloc() : super(ProfileMenuState.initial()) {
    on<ProfileMenuInitialized>(_onInitialized);
    on<DeleteAccountEvent>(_deleteAccount);
    _userDataSource = UserDataSource();
  }

  Future<void> _deleteAccount(
      DeleteAccountEvent event, Emitter<ProfileMenuState> emit) async {
    emit(state.copyWith(isLoading: true));
    if (user != null) {
      var isDelete = await _userDataSource.deleteAccount(id: user!.id);

      emit(state.copyWith(isDeleted: isDelete));
    }
    emit(state.copyWith(isLoading: false));
  }

  Future<void> _onInitialized(
      ProfileMenuInitialized event, Emitter<ProfileMenuState> emit) async {
    emit(state.copyWith(isLoading: true));

    user = await _userDataSource.me();
    if (user == null) {
      emit(state.copyWith(
        isLoading: false,
        userName: ' ',
        email: ' ',
      ));
    } else {
      emit(state.copyWith(
        isLoading: false,
        userName: user!.fullName,
        email: user!.email,
      ));
    }
  }
}
