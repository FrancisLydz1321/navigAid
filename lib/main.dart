import 'package:flutter/material.dart';
import 'package:navigaid/app_colors.dart';
import 'package:navigaid/screens/blind_option_screen.dart';
import 'package:navigaid/screens/introduction_screen.dart';
import 'package:navigaid/screens/maps_screen.dart';
import 'package:navigaid/screens/select_an_option_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NAVIGAID',
      theme: ThemeData(
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          color: AppColors.grey,
          iconTheme: IconThemeData(
            size: 32,
            color: AppColors.black,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
        ),
        useMaterial3: true,
      ),
      routes: {
        // what is route in flutter
        // necessary format for routes
        '/': (context) =>
            const IntroductionScreen(), // arrow/ anonymous function
        '/select-an-option': (context) => const SelectAnOptionScreen(),
        '/blind-option': (context) => const BlindOptionScreen(),
        '/maps': (context) => const MapsScreen(),
      },
    );
  }
}
