import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './place_detail_screen.dart';
import './add_place_screen.dart';
import '../providers/places.dart';

class PlacesListScreen extends StatelessWidget {
  // Route name to screen.
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Places>(context, listen: false).fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<Places>(
                child: Center(
                  child: Text('Got no places yet...'),
                ),
                builder: (ctx, places, ch) => places.items.isEmpty
                    ? ch
                    : ListView.builder(
                        itemCount: places.items.length,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(places.items[i].image),
                          ),
                          title: Text(places.items[i].title),
                          subtitle: Text(places.items[i].location.address),
                          onTap: () {
                            // Segue to details page...
                            Navigator.of(context).pushNamed(
                              PlaceDetailScreen.routeName,
                              arguments: places.items[i].id,
                            );
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}
