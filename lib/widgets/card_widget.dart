import 'package:flutter/material.dart';
import 'package:navigaid/app_colors.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.title,
    this.image,
    this.onTap,
    this.backgroundColor,
    this.fontSize,
    this.fontColor,
    this.customTitle,
  });

  final String title;
  final Widget? customTitle;
  final String? image;
  final Color? backgroundColor;
  final void Function()? onTap;
  final double? fontSize;
  final Color? fontColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppColors.green,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.lightGreen,
            border: Border.all(width: 4),
            borderRadius: BorderRadius.circular(35),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (image != null && image!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Image.asset(
                    image!,
                    width: 80,
                    height: 80,
                  ),
                ),
              Flexible(
                child: customTitle ??
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fontSize ?? 26,
                        color: fontColor,
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
