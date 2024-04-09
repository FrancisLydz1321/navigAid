import 'package:flutter/material.dart';
import 'package:navigaid/models/card_value_model.dart';
import 'package:navigaid/screens/maps_screen.dart';
import 'package:navigaid/widgets/card_widget.dart';
import 'package:navigaid/widgets/custom_appbar_widget.dart';

class BlindOptionScreen extends StatelessWidget {
  const BlindOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<CardValue> buttons = <CardValue>[
      CardValue(
        image: 'assets/images/el_car.png',
        text: 'Transportation',
        screen: const MapsScreen(),
      ),
      // CardValue(
      //   image: '',
      //   text: '',
      // ),
      CardValue(
        image: 'assets/images/ic_baseline-people.png',
        text: 'Companion Link',
      ),
    ];

    return Scaffold(
      appBar: const CustomAppbar(title: 'For Blind Option'),
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
