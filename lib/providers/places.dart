import 'dart:io';

import 'package:flutter/foundation.dart';

import '../helpers/location_helper.dart';
import '../helpers/db_helper.dart';
import '../models/place.dart';

// Blueprint for a list of places.
class Places with ChangeNotifier {
  // List of places.
  List<Place> _items = [];

  // Get the list of places.
  List<Place> get items {
    return [..._items];
  }

  // Find place by id.
  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  // Add new place to list of places.
  // Notify all items listeners when new place is added.
  Future<void> addPlace(
      {String pickedTitle,
      File pickedImage,
      PlaceLocation pickedLocation}) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: updatedLocation,
    );

    // Add new place to our list of places.
    _items.add(newPlace);
    notifyListeners();

    // Add new place to our SQLite database.
    DBHelper.insert(
      'user_places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        'loc_lat': newPlace.location.latitude,
        'loc_lng': newPlace.location.longitude,
        'address': newPlace.location.address,
      },
    );
  }

  // Fetch data from SQLite database and map it to our places list.
  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');

    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
              latitude: item['loc_lat'],
              longitude: item['loc_lng'],
              address: item['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
