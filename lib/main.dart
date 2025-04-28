import 'package:flutter/material.dart';
import 'package:giripet_mobile/core/constants/shared_preference_keys.dart';
import 'package:giripet_mobile/data/datasources/user_datasource.dart';
import 'package:giripet_mobile/presentation/routes/bottom_navigation_screen.dart';
import 'package:giripet_mobile/presentation/screens/edit_profile/edit_profile_screen.dart';
import 'package:giripet_mobile/presentation/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'presentation/screens/login/login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'presentation/screens/register/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> hasToken() async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(SharedPreferenceKeys.token);
      return token != null && token.isNotEmpty;
    }

    return MaterialApp(
      title: 'GiriPet',
      theme: ThemeData(primarySwatch: Colors.teal),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('tr'),
        Locale('en'),
      ],
      routes: {
        '/register': (context) => const RegisterScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/edit_profile': (context) => EditProfileScreen(),
      },
      home: FutureBuilder<bool>(
        future: hasToken(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.data == true) {
            return const BottomNavigationController(); // Token varsa Dashboard
          } else {
            return const LoginScreen(); // Token yoxdursa Login
          }
        },
      ),
    );
  }
}
