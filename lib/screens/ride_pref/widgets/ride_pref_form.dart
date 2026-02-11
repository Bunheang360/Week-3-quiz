import 'package:flutter/material.dart';

import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';

import '../../../theme/theme.dart';
import '../../../widgets/actions/bla_button.dart';
import '../../../utils/date_time_util.dart';
import '../../../widgets/display/bla_divider.dart';
import '../../../widgets/inputs/bla_location_picker.dart';
import './ride_pref_tile.dart';
import '../../ride/ride_screen.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;



  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    // TODO
    //Initialize data first
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      // If no initial RidePref is provided, initialize with default values
      departureDate = DateTime.now();
      requestedSeats = 1;
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
  void onDeparture() async {
    //Select location
    Location? selectLocation = await Navigator.of(context).push<Location>(
      MaterialPageRoute(builder: (context) => BlaLocationPicker(
      )),
    );
    //Rebuild if user select location
    if (selectLocation != null) {
      setState(() {
        departure = selectLocation;
      });
    }
  }

  void onArrival() async {
    //Select location
    Location? selectLocation = await Navigator.of(context).push<Location>(
      MaterialPageRoute(builder: (context) => BlaLocationPicker(
      )),
    );
    //Rebuild if user select location
    if (selectLocation != null) {
      setState(() {
        arrival = selectLocation;
      });
    }
  }

  void switchLocations() {
    setState(() {
      // For switching location if both departure and arrival are not null
      if (departure != null && arrival != null) {
        final temp = departure!;
        departure = arrival;
        arrival = temp;
      }
    });
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  String get departureLabel => departure != null ? departure!.name : "Leaving from";
  String get arrivalLabel => arrival != null ? arrival!.name : "Going to";
  String get dateLabel => DateTimeUtils.formatDateTime(departureDate);
  bool get switchVisible => departure != null || arrival != null; // Show switch button if at least one of the location is selected

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: BlaSpacings.l), 
          child: Column(
            children: [
              // Depature Tile
              RidePrefTile(
                placeholder: departure == null,
                label: departureLabel,
                icon: Icons.location_on,
                onPressed: onDeparture,

                // Switch location button
                switchIcon: switchVisible ? Icons.swap_vert : null,
                onSwitchPressed: switchVisible ? switchLocations : null,
              ),

              const BlaDivider(),

              // Arrival Tile
              RidePrefTile(
                placeholder: arrival == null,
                label: arrivalLabel,
                icon: Icons.flag,
                onPressed: onArrival,
              ),

              const BlaDivider(),

              // Date Tile
              RidePrefTile(
                label: dateLabel,
                icon: Icons.calendar_today,
                onPressed: () => {},
              ),

              const BlaDivider(),

              // Seats Tile
              RidePrefTile(
                label: requestedSeats.toString(),
                icon: Icons.event_seat,
                onPressed: () => {},
              ),

              const SizedBox(height: BlaSpacings.m),

              // Search Button
              BlaButton(
                label: "Search",
                type: ButtonType.primary,
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute (
                    builder: (context) => RideScreen(),
                  )
                )
              )
            ],
          )
        )
      ],
    );
  }
}
