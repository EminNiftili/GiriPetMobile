import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giripet_mobile/logic/blocs/register/register_bloc.dart';
import 'package:giripet_mobile/logic/blocs/register/register_state.dart';
import 'package:giripet_mobile/presentation/widgets/backgroundDecoration.dart';
import 'register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: BlocProvider(
        create: (_) => RegisterBloc(),
        child: Stack(
          children: [
            const Positioned.fill(child: BackgroundDecoration()),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.pets, size: 72, color: Colors.teal),
                    const SizedBox(height: 16),
                    Text(
                      'Create Account',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.teal.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    BlocListener<RegisterBloc, RegisterState>(
                      listener: (context, state) {
                        if (state.isSuccess) {
                          Navigator.of(context).pushReplacementNamed('/home');
                        }
                      },
                      child: const RegisterForm(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
