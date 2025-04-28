import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giripet_mobile/logic/blocs/register/register_bloc.dart';
import 'package:giripet_mobile/logic/blocs/register/register_event.dart';
import 'package:giripet_mobile/logic/blocs/register/register_state.dart';
import 'package:giripet_mobile/presentation/widgets/loading_overlay.dart';
import 'register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: BlocListener<RegisterBloc, RegisterState>(
        listenWhen: (previous, current) =>
            previous.isFailure != current.isFailure,
        listener: (context, state) {
          if (state.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          } else {
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return LoadingOverlay(
                isLoading: state.isLoading,
                child: Scaffold(
                  backgroundColor: const Color(0xFFF5F7FA),
                  body: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.pets, size: 64, color: Colors.teal),
                          const SizedBox(height: 8),
                          Text(
                            "GiriPet",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  color: Colors.teal.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 24),
                          const RegisterForm(), // 👈 sadece input'ları içeriyor
                          const SizedBox(height: 24),
                          const _AlreadyHaveAccountLabel(), // 👈 Yeni label
                          const SizedBox(height: 12),
                          _RegisterButton(), // 👈 card'ın dışında
                        ],
                      ),
                    ),
                  ),
                ));
          },
        ),
      ),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<RegisterBloc>().add(const RegisterSubmitted());
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 64),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.teal.shade600,
        elevation: 6,
      ),
      child: const Text(
        'Register',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}

class _AlreadyHaveAccountLabel extends StatelessWidget {
  const _AlreadyHaveAccountLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context); // 👈 Login sayfasına geri döner
      },
      child: const Text(
        'Already have an account? Login',
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
