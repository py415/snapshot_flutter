import 'dart:io';

import 'package:flutter/foundation.dart';

import '../helpers/db_helper.dart';
import '../models/place.dart';

// Blueprint for a list of places.
class Places with ChangeNotifier {
  // List of places.
  final List<Place> _items = [];

  // Get the list of places.
  List<Place> get items {
    return [..._items];
  }

  // Add new place to list of places.
  // Notify all items listeners when new place is added.
  void addPlace({String pickedTitle, File pickedImage}) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: null,
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
      },
    );
  }

  // Fetch data from SQLite database and map it to our places list.
  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');

    dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: null,
          ),
        )
        .toList();
    notifyListeners();
  }
}
