import 'package:flutter/material.dart';

Widget iconButtonWithShadow({
  required IconData icon,
  required Color activeColor,
  required bool isActive,
  required VoidCallback onPressed,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.4),
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: IconButton(
      icon: Icon(icon, size: 32, color: isActive ? activeColor : Colors.white),
      onPressed: onPressed,
    ),
  );
}
