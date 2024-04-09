import 'package:flutter/material.dart';
import 'package:navigaid/screens/select_an_option_screen.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SelectAnOptionScreen(),
              ),
            );
          },
          child: const Text('hehe'),
        ),
      ),
    );
  }
}
