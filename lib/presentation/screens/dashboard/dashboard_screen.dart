import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giripet_mobile/logic/blocs/dashboard/dashboard_bloc.dart';
import 'package:giripet_mobile/logic/blocs/dashboard/dashboard_event.dart';
import 'package:giripet_mobile/logic/blocs/dashboard/dashboard_state.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc()..add(DashboardInitialized()),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('GiriPet'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //ProfileBannerArea(userName: 'Emin Niftili'), // 👈 Bloc-dan gələcək
                  const SizedBox(height: 16),
                  //const PetListArea(), // 👈 Bloc-dan pet list gələcək
                  const SizedBox(height: 16),
                  //const UpcomingWalksArea(), // 👈 Bloc-dan upcoming walks
                  const SizedBox(height: 16),
                  //const RecentWalksArea(), // 👈 Bloc-dan recent walks
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
