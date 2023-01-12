import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'colors.dart';

class ImageButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const ImageButton({super.key, required this.text,  required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:  BoxConstraints(
          minWidth: 10.w,
          minHeight: 5.h
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: const EdgeInsets.all(15.0),
        ),
        onPressed: onPressed,
        child: Text(text,
        ),
      ),
    );
  }
}
