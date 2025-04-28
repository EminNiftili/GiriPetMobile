import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giripet_mobile/logic/blocs/register/register_bloc.dart';
import 'package:giripet_mobile/logic/blocs/register/register_event.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInput('Full Name', Icons.person, onChanged: (value) {
              context.read<RegisterBloc>().add(RegisterNameChanged(value));
            }),
            const SizedBox(height: 16),
            _buildInput('Email', Icons.email,
                keyboardType: TextInputType.emailAddress, onChanged: (value) {
              context.read<RegisterBloc>().add(RegisterEmailChanged(value));
            }),
            const SizedBox(height: 16),
            _buildInput('Phone Number', Icons.phone,
                keyboardType: TextInputType.phone, onChanged: (value) {
              context.read<RegisterBloc>().add(RegisterPhoneChanged(value));
            }),
            const SizedBox(height: 16),
            _buildInput('Password', Icons.lock, obscureText: true,
                onChanged: (value) {
              context.read<RegisterBloc>().add(RegisterPasswordChanged(value));
            }),
            const SizedBox(height: 16),
            _buildInput('Confirm Password', Icons.lock, obscureText: true,
                onChanged: (value) {
              context
                  .read<RegisterBloc>()
                  .add(RegisterConfirmPasswordChanged(value));
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(
    String label,
    IconData icon, {
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    required Function(String) onChanged,
  }) {
    return TextField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onChanged: onChanged,
    );
  }
}
