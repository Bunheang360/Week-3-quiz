import 'package:flutter/material.dart';

import '../../model/ride/locations.dart';
import '../../service/locations_service.dart';
import '../../theme/theme.dart';
import '../../widgets/inputs/location_tile.dart';

class BlaLocationPicker extends StatefulWidget {
  const BlaLocationPicker({super.key});

  @override
  State<BlaLocationPicker> createState() => _BlaLocationPickerState();
}

class _BlaLocationPickerState extends State<BlaLocationPicker> {
  late List<Location> _filtheredLocations;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _filtheredLocations = LocationsService.availableLocations;
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool get _searchIsNotEmpty => _searchController.text.isNotEmpty;

  void filterLocations(String input) {
    setState(() {
      if (input.isEmpty) {
        _filtheredLocations = LocationsService.availableLocations;
      } else {
        _filtheredLocations = LocationsService.availableLocations
            .where(
              (location) =>
                  location.name.toLowerCase().contains(input.toLowerCase()) ||
                  location.country.name.toLowerCase().contains(
                    input.toLowerCase(),
                  ),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.l,
          right: BlaSpacings.l,
          top: BlaSpacings.m,
        ),
        child: Column(
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: BlaColors.backgroundAccent,
                borderRadius: BorderRadius.circular(BlaSpacings.radius),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 16,
                        color: BlaColors.iconLight,
                      ),
                    ),
                  ),

                  // Filther Fucntion, will rebuild when user input
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        filterLocations(value);
                        setState(() {});
                      },
                      controller: _searchController,
                      style: TextStyle(color: BlaColors.textLight),
                      decoration: InputDecoration(
                        hintText: "Any city, street...",
                        border: InputBorder.none,
                        filled: false,
                      ),
                    ),
                  ),

                  // Cross Icon to clear the search input and visible only if there is input
                  _searchIsNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.close, color: BlaColors.iconLight),
                          onPressed: () {
                            _searchController.clear();
                            filterLocations("");
                          },
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),

            // Get location lis
            Expanded(
              child: ListView.builder(
                itemCount: _filtheredLocations.length,
                itemBuilder: (context, index) {
                  return LocationTile(
                    location: _filtheredLocations[index],
                    onPressed: () {
                      Navigator.pop(context, _filtheredLocations[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
