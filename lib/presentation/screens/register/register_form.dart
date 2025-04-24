import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giripet_mobile/logic/blocs/register/register_bloc.dart';
import 'package:giripet_mobile/logic/blocs/register/register_event.dart';
import 'package:giripet_mobile/logic/blocs/register/register_state.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: (value) =>
                  context.read<RegisterBloc>().add(RegisterNameChanged(value)),
              decoration: const InputDecoration(
                labelText: 'Full Name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              onChanged: (value) =>
                  context.read<RegisterBloc>().add(RegisterEmailChanged(value)),
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              onChanged: (value) =>
                  context.read<RegisterBloc>().add(RegisterPasswordChanged(value)),
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              onChanged: (value) => context
                  .read<RegisterBloc>()
                  .add(RegisterConfirmPasswordChanged(value)),
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
            const SizedBox(height: 24),
            if (state.isFailure)
              const Text(
                'Registration failed!',
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            if (state.isSuccess)
              const Text(
                'Registration successful!',
                style: TextStyle(color: Colors.green),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Geri dönüş
              },
              child: const Text(
                'Already have an account? Sign in',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              onPressed: state.isSubmitting
                  ? null
                  : () {
                context.read<RegisterBloc>().add(const RegisterSubmitted());
              },
              child: state.isSubmitting
                  ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
                  : const Text('Sign Up'),
            ),
          ],
        );
      },
    );
  }
}
