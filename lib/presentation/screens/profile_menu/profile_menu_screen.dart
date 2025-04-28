import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giripet_mobile/logic/blocs/profile_menu/profile_menu_bloc.dart';
import 'package:giripet_mobile/logic/blocs/profile_menu/profile_menu_event.dart';
import 'package:giripet_mobile/logic/blocs/profile_menu/profile_menu_state.dart';
import 'package:giripet_mobile/presentation/screens/profile_menu/profile_menu_section.dart';

class ProfileMenuScreen extends StatelessWidget {
  const ProfileMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileMenuBloc()..add(ProfileMenuInitialized()),
      child: BlocBuilder<ProfileMenuBloc, ProfileMenuState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile section
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 35,
                        child: Icon(Icons.person, size: 35),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.userName,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            state.email,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Menu Sections
                  const ProfileMenuSection(
                    icon: Icons.person_outline,
                    title: 'Şəxsi Məlumatlar',
                  ),
                  const Divider(),

                  const ProfileMenuSection(
                    icon: Icons.lock_outline,
                    title: 'Şifrə Dəyişdir',
                  ),
                  const Divider(),

                  const ProfileMenuSection(
                    icon: Icons.language,
                    title: 'Dil Dəyişdir',
                  ),
                  const Divider(),

                  const ProfileMenuSection(
                    icon: Icons.logout,
                    title: 'Çıxış Et',
                    isLogout: true,
                  ),
                  const Divider(),

                  const ProfileMenuSection(
                    icon: Icons.delete_forever,
                    title: 'Hesabı Sil',
                    isDanger: true,
                  ),

                  const SizedBox(height: 32),
                  const Text(
                    'Mənim Heyvanlarım',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
