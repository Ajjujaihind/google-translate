import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? buttonText;
  final void Function()? onPressed;

  CustomButton({Key? key, required this.buttonText, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        constraints: BoxConstraints(
            minWidth: 150, minHeight: 50), // Minimum width for the button
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, // Make the row occupy minimum space
          children: [
            Text(
              buttonText!,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Color(0xff3a3b3d),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
