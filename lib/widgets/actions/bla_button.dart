import 'package:flutter/material.dart';
import '../../theme/theme.dart';

enum ButtonType { primary, secondary }

class BlaButton extends StatelessWidget {
  const BlaButton({super.key, required this.label, this.icon, this.type = ButtonType.primary, this.onPressed});

  final String label;
  final IconData? icon;
  final ButtonType type;

  final VoidCallback? onPressed;

  bool get isPrimary => type == ButtonType.primary;

  Color get backgroundColor => isPrimary ? BlaColors.backGroundColor : BlaColors.white;

  Color get textColor => isPrimary ? BlaColors.white : BlaColors.backGroundColor;

  Color get iconColor => isPrimary ? BlaColors.white : BlaColors.backGroundColor;

  Color get borderColor => backgroundColor == BlaColors.primary ? BlaColors.primary : BlaColors.backGroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
            side: BorderSide(
              color: borderColor,
              width: 1.5,
            ),
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}