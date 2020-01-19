import 'package:flutter/material.dart';

final _addLocationKey = GlobalKey<FormState>();

class AddLocation extends StatelessWidget {
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
