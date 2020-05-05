import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final _addLocationKey = GlobalKey<FormState>();

class AddLocation extends StatefulWidget {
  @override
  _AddLocationState createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Nowa lokalizacja'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Center(
        key: _addLocationKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Podaj nazwę nowej lokalizacji',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Wprowadz jakas nazwe';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Adres',
              ),
            ),
            Card(
              child: ExpansionTile(
                leading: Icon(Icons.location_on),
                title: Text('Wybór z mapy'),
                children: <Widget>[
                  Container(
                    height: 300,
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(53.0321480, 18.6060900),
                        zoom: 11.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 16.0,
        icon: Icon(Icons.location_on),
        label: Text('Dodaj'),
        onPressed: () {
          print('Dodanie lokalizacji');
        },
      ),
    );
  }
}
