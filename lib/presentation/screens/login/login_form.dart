import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giripet_mobile/logic/blocs/auth/auth_bloc.dart';
import 'package:giripet_mobile/logic/blocs/auth/auth_event.dart';
import 'package:giripet_mobile/logic/blocs/auth/auth_state.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: (value) =>
                  context.read<AuthBloc>().add(AuthEmailChanged(value)),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: (value) =>
                  context.read<AuthBloc>().add(AuthPasswordChanged(value)),
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),
            if (state.isFailure)
              const Text(
                'Invalid credentials!',
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            if (state.isSuccess)
              const Text(
                'Login successful!',
                style: TextStyle(color: Colors.green),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 16),
            InkWell(
              onTap: state.isSubmitting
                  ? null
                  : () {
                      context.read<AuthBloc>().add(const AuthSubmitted());
                    },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color:
                      state.isSubmitting ? Colors.teal.shade200 : Colors.teal,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: state.isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/forgot_password');
              },
              child: const Text(
                'Forgot your password?',
                style: TextStyle(color: Colors.teal),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/register');
              },
              child: const Text(
                'Don\'t have an account? Sign up',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }
}
