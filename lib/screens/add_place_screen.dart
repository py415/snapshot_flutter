import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/place.dart';
import '../providers/places.dart';
import '../widgets/image_input.dart';
import '../widgets/location_input.dart';

// Blueprint for adding a new place screen.
class AddPlaceScreen extends StatefulWidget {
  // Route name to screen.
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  // Controller for title text field.
  final _titleController = TextEditingController();
  // Image file that user picked from photo library or taken from camera app.
  File _pickedImage;
  PlaceLocation _pickedLocation;

  // Set selected image for image input.
  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  // Save and add new place to list of location.
  void _savePlace() {
    // Check if text, image, and location fields are empty.
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) {
      return;
    }

    // Add new place to list of places.
    Provider.of<Places>(context, listen: false).addPlace(
      pickedTitle: _titleController.text,
      pickedImage: _pickedImage,
      pickedLocation: _pickedLocation,
    );

    // Pop off current screen and navigate back to to list of places screen.
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      controller: _titleController,
                    ),
                    SizedBox(height: 10.0),
                    ImageInput(onSelectImage: _selectImage),
                    SizedBox(height: 10.0),
                    LocationInput(onSelectPlace: _selectPlace),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: RaisedButton.icon(
              icon: Icon(Icons.add),
              label: Text('Add Place'),
              elevation: 0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              color: Theme.of(context).accentColor,
              onPressed: _savePlace,
            ),
          ),
        ],
      ),
    );
  }
}
