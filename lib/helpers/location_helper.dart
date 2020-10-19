import 'dart:convert';

import 'package:http/http.dart' as http;

// ignore: todo
// TODO: REMOVE API KEY BEFORE COMMITING TO GITHUB!
// API key for Google Cloud Platform - Google Maps.
const _GOOGLE_API_KEY = 'ADD_API_KEY_HERE';

// Blueprint for location helper class used for Google Maps API.
class LocationHelper {
  // Generate preview image of map based on users current location or selected location.
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$_GOOGLE_API_KEY';
  }

  // Get address with Google Maps API based on user selected latitude and longitude.
  static Future<String> getPlaceAddress(
      double latitude, double longitude) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$_GOOGLE_API_KEY';
    final response = await http.get(url);

    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
