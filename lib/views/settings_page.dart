import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movietest/controllers/settings_controller.dart';

class SettingsPage extends StatelessWidget {
  final SettingsController _settingsController = Get.find<SettingsController>();

  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Obx(() {
        // Use Obx to rebuild when theme changes
        return ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            Text(
              'Theme Mode',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Light Mode'),
              value: ThemeMode.light,
              groupValue: _settingsController.currentTheme.value,
              onChanged: (ThemeMode? value) {
                if (value != null) {
                  _settingsController.changeTheme(value);
                }
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Dark Mode'),
              value: ThemeMode.dark,
              groupValue: _settingsController.currentTheme.value,
              onChanged: (ThemeMode? value) {
                if (value != null) {
                  _settingsController.changeTheme(value);
                }
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('System Default'),
              value: ThemeMode.system,
              groupValue: _settingsController.currentTheme.value,
              onChanged: (ThemeMode? value) {
                if (value != null) {
                  _settingsController.changeTheme(value);
                }
              },
            ),
            const Divider(),
            // Add other settings here in the future
            // Example: About section
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              subtitle: const Text('MovieTest App v1.0.0'),
              onTap: () {
                Get.dialog(
                  AlertDialog(
                    title: const Text('About MovieTest'),
                    content: const SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('Version: 1.0.0'),
                          Text('Developed with Flutter & GetX.'),
                          Text('Enjoy browsing movies!'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Close'),
                        onPressed: () {
                          Get.back(); // Close the dialog
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      }),
    );
  }
}
