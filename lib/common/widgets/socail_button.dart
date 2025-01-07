import 'package:flutter/material.dart';

import '../../core/configs/theme/app_colors.dart';

class SocialButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;
  final Color color;

  SocialButton({ required this.label, required this.onPressed, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: color
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon != null ? Icon(icon, size: 24.0, color: Colors.white,) : const SizedBox.shrink(),
            const SizedBox(width: 16), // Add some spacing between icon and text
            Expanded( // Use Expanded to take up remaining space
              child: Center(
                child: Text(
                  label,
                  style: const TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),
                  textAlign: TextAlign.center, // Center text within available space
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}