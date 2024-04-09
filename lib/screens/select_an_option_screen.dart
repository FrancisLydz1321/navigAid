import 'package:flutter/material.dart';
import 'package:navigaid/models/card_value_model.dart';
import 'package:navigaid/screens/blind_option_screen.dart';
import 'package:navigaid/widgets/card_widget.dart';
import 'package:navigaid/widgets/custom_appbar_widget.dart';

class SelectAnOptionScreen extends StatelessWidget {
  const SelectAnOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<CardValue> buttons = <CardValue>[
      // flutter list view
      CardValue(
        image: 'assets/images/el_blind.png',
        text: 'BLIND',
        screen: const BlindOptionScreen(),
      ),
      // CardValue(
      //   image: '',
      //   text: '',
      // ),
      CardValue(
        image: 'assets/images/bx_color.png',
        text: 'Color Blind',
      ),
    ];
    return Scaffold(
      appBar: const CustomAppbar(title: 'Select an Option'),
      body: ListView.separated(
        itemCount: buttons.length,
        padding: const EdgeInsets.all(12),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final button = buttons[index];
          return CardWidget(
            title: button.text,
            image: button.image,
            onTap: () {
              if (button.screen != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => button.screen!,
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
