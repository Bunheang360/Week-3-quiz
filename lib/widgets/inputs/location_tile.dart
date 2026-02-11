import 'package:flutter/material.dart';
import '../../model/ride/locations.dart';
import '../../theme/theme.dart';

class LocationTile extends StatelessWidget {
  const LocationTile({
    super.key,
    required this.location,
    required this.onPressed,
  });

  final Location location;
  final VoidCallback onPressed;

  String get cityName => location.name;
  String get countryName => location.country.name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      title: Text(
        cityName,
        style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal),
      ),
      subtitle: Text(
        countryName,
        style: BlaTextStyles.label.copyWith(color: BlaColors.textLight),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: BlaColors.iconLight,
        size: 18,
      ),
    );
  }
}
