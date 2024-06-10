import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double iconSize;

  const CircleButton({
    required this.icon,
    required this.onPressed,
    this.iconSize = 24.0, // Default icon size
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onPressed,
        child: Container(
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xff886ff2), // Use the primary light color
          ),
          child: Center(
            child: Icon(
              icon,
              size: iconSize,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
