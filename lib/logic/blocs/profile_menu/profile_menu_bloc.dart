import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giripet_mobile/data/datasources/user_datasource.dart';
import 'profile_menu_event.dart';
import 'profile_menu_state.dart';

class ProfileMenuBloc extends Bloc<ProfileMenuEvent, ProfileMenuState> {
  late UserDataSource _userDataSource;
  ProfileMenuBloc() : super(ProfileMenuState.initial()) {
    on<ProfileMenuInitialized>(_onInitialized);
    _userDataSource = UserDataSource();
  }

  Future<void> _onInitialized(
      ProfileMenuInitialized event, Emitter<ProfileMenuState> emit) async {
    emit(state.copyWith(isLoading: true));

    var user = await _userDataSource.me();
    if (user == null) {
      emit(state.copyWith(
        isLoading: false,
        userName: ' ',
        email: ' ',
      ));
    } else {
      emit(state.copyWith(
        isLoading: false,
        userName: user.fullName,
        email: user.email,
      ));
    }
  }
}
