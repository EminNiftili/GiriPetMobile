import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giripet_mobile/logic/blocs/auth/auth_bloc.dart';
import 'package:giripet_mobile/logic/blocs/auth/auth_state.dart';
import 'package:giripet_mobile/presentation/routes/bottom_navigation_screen.dart';
import 'package:giripet_mobile/presentation/screens/login/login_form.dart';
import 'package:giripet_mobile/presentation/widgets/backgroundDecoration.dart';
import 'package:giripet_mobile/presentation/widgets/loading_overlay.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => AuthBloc(),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.isSuccess) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const BottomNavigationController()),
                (route) => false,
              );
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return LoadingOverlay(
                  isLoading: false,
                  child: Scaffold(
                    backgroundColor: Colors.grey.shade100,
                    body: Stack(
                      children: [
                        const Positioned.fill(child: BackgroundDecoration()),
                        Center(
                          child: SingleChildScrollView(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.pets,
                                    size: 72, color: Colors.teal),
                                const SizedBox(height: 16),
                                Text(
                                  'GiriPet',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        color: Colors.teal.shade700,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 32),
                                const LoginForm(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
            },
          ),
        ));
  }
}
