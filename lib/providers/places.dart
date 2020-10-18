import 'dart:io';

import 'package:flutter/foundation.dart';

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

    _items.add(newPlace);
    notifyListeners();
  }
}
