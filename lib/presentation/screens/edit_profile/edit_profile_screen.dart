import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giripet_mobile/logic/blocs/edit_profile/edit_profile_bloc.dart';
import 'package:giripet_mobile/logic/blocs/edit_profile/edit_profile_event.dart';
import 'package:giripet_mobile/logic/blocs/edit_profile/edit_profile_state.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileBloc()..add(LoadProfileRequested()),
      child: BlocBuilder<EditProfileBloc, EditProfileState>(
        builder: (context, state) {
          final nameController = TextEditingController(text: state.name);
          final phoneController = TextEditingController(text: state.phone);
          final emailController = TextEditingController(text: state.email);

          return Scaffold(
            backgroundColor: const Color(0xFFF5F7FA),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.teal,
                          child:
                              Icon(Icons.person, size: 50, color: Colors.white),
                        ),
                        if (state.isEditing)
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.camera_alt, size: 16),
                              onPressed: () {
                                // Profil şəkli dəyişdirmək üçün
                              },
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Ad Soyad
                    _buildInputField(
                      controller: nameController,
                      label: 'Ad Soyad',
                      enabled: state.isEditing,
                    ),
                    const SizedBox(height: 16),

                    // Email
                    _buildInputField(
                      controller: emailController,
                      label: 'Email',
                      enabled: false, // Email dəyişməsin
                    ),
                    const SizedBox(height: 16),

                    // Telefon
                    _buildInputField(
                      controller: phoneController,
                      label: 'Telefon',
                      enabled: state.isEditing,
                    ),

                    const Spacer(),

                    if (!state.isEditing) ...[
                      ElevatedButton(
                        onPressed: () {
                          context.read<EditProfileBloc>().add(ToggleEditing());
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Edit Profile'),
                      ),
                    ] else ...[
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Save funksiyası sonra
                                context
                                    .read<EditProfileBloc>()
                                    .add(ToggleEditing());
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                backgroundColor: Colors.teal,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              child: const Text('Save'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                context
                                    .read<EditProfileBloc>()
                                    .add(ToggleEditing());
                              },
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                side: const BorderSide(color: Colors.teal),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              child: const Text('Cancel',
                                  style: TextStyle(color: Colors.teal)),
                            ),
                          ),
                        ],
                      ),
                    ],

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    bool enabled = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          labelText: label,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
