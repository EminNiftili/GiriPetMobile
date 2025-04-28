import 'package:flutter/material.dart';

class ProfileMenuSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isLogout;
  final bool isDanger;

  const ProfileMenuSection({
    super.key,
    required this.icon,
    required this.title,
    this.isLogout = false,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.black;
    if (isLogout) textColor = Colors.red;
    if (isDanger) textColor = Colors.red.shade700;

    return ListTile(
      leading: Icon(icon, color: textColor),
      title: Text(
        title,
        style: TextStyle(color: textColor),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // TODO: Navigasiya edəcəyik
      },
    );
  }
}
