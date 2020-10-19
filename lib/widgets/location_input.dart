import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../screens/map_screen.dart';
import '../helpers/location_helper.dart';

// Blueprint for location input.
class LocationInput extends StatefulWidget {
  // Method that handles user selected location.
  final Function onSelectPlace;

  LocationInput({this.onSelectPlace});

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  // Google Maps Static API URL.
  String _previewImageUrl;

  // Update static map url for Google Map preview.
  void _showPreview({double lat, double lng}) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: lat, longitude: lng);

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  // Get current user location.
  Future<void> _getCurrentUserLocation() async {
    try {
      // Current user location.
      final locationData = await Location().getLocation();

      // Show preview on Google Maps with user position (latitude and longitude).
      _showPreview(lat: locationData.latitude, lng: locationData.longitude);

      widget.onSelectPlace(locationData.latitude, locationData.longitude);
    } catch (error) {
      return;
    }
  }

  // User can select a custom map location.
  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );

    // Return back to AddPlaceScreen without a location if no marker or location was set in location picker.
    if (selectedLocation == null) {
      return;
    }

    _showPreview(
        lat: selectedLocation.latitude, lng: selectedLocation.longitude);

    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _getCurrentUserLocation,
            ),
            FlatButton.icon(
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _selectOnMap,
            ),
          ],
        ),
      ],
    );
  }
}
