import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movietest/controllers/settings_controller.dart';
import 'package:movietest/views/splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(SettingsController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final SettingsController _settingsController = Get.find<SettingsController>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: _settingsController.currentTheme.value,
          theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.deepPurple,
              primaryColor: Colors.deepPurple,
              scaffoldBackgroundColor: Colors.grey[100],
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.deepPurple,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(color: Colors.white),
              ),
              textTheme: TextTheme(
                bodyLarge: TextStyle(color: Colors.black87),
                bodyMedium: TextStyle(color: Colors.black87),
                titleLarge:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              cardTheme: CardTheme(
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              listTileTheme: ListTileThemeData(
                tileColor: Colors.white,
                textColor: Colors.black87,
              ),
              chipTheme: ChipThemeData(
                backgroundColor: Colors.deepPurple.withOpacity(0.1),
                labelStyle: TextStyle(color: Colors.deepPurple[800]),
                secondarySelectedColor: Colors.deepPurple,
                selectedColor: Colors.deepPurple,
                shape: StadiumBorder(),
              )),
          darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.deepPurple,
              primaryColor: const Color(0xFF2A0944),
              scaffoldBackgroundColor: const Color(0xFF2A0944),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF3B185F),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(color: Colors.white),
              ),
              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Colors.white),
                bodyMedium: TextStyle(color: Colors.white),
                titleLarge:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              cardTheme: CardTheme(
                color: Color(0xFF3B185F).withOpacity(0.7),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              listTileTheme: ListTileThemeData(
                tileColor: Color(0xFF3B185F).withOpacity(0.5),
                textColor: Colors.white,
              ),
              chipTheme: ChipThemeData(
                backgroundColor: Colors.white.withOpacity(0.12),
                labelStyle: TextStyle(color: Colors.white),
                secondarySelectedColor: Colors.deepPurpleAccent,
                selectedColor: Colors.deepPurpleAccent,
                shape: StadiumBorder(),
              )),
          home: const SplashScreen(),
        ));
  }
}
