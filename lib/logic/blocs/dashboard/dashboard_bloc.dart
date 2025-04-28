import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardState.initial()) {
    on<DashboardInitialized>(_onInitialized);
  }

  Future<void> _onInitialized(
    DashboardInitialized event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    await Future.delayed(const Duration(seconds: 2)); // API simulyasiyası

    emit(state.copyWith(
      isLoading: false,
    ));
  }
}
