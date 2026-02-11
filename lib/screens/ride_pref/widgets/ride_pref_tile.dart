import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

class RidePrefTile extends StatelessWidget {
  const RidePrefTile({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.placeholder = false, //Turn off for now
    this.switchIcon,
    this.onSwitchPressed,
  });

  final String label;
  final IconData icon;
  final bool placeholder; // placeholder for departure and arrival tiles

  final IconData? switchIcon; // switch location for departure and arrival

  final VoidCallback? onSwitchPressed;
  final VoidCallback onPressed;

  Color get textColor => placeholder ? BlaColors.textLight : BlaColors.textNormal;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      title: Text(
        label,
        style: BlaTextStyles.body.copyWith(
          fontSize: 14, 
          color: textColor
        ),
      ),
      leading: Icon(
        icon, 
        size: 18, 
        color: BlaColors.iconLight
        ),
      trailing: switchIcon != null
          ? IconButton(
              onPressed: onSwitchPressed,
              icon: Icon(
                switchIcon, 
                color: BlaColors.primary
              ),
            )
          : null,
    );
  }
}
