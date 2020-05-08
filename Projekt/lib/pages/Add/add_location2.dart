import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:throttling/throttling.dart';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:pageview/Classes/Localization.dart';

// Autosugestia adresow
Future<List> fetchAddress(String query, LatLng position) async {
  String fullQuery = 'https://autosuggest.search.hereapi.com/v1/autosuggest?at=' +
      position.latitude.toString() +
      "," +
      position.longitude.toString() +
      "&limit=5&lang=pl&q=" +
      query +
      "&apiKey=wCXJuE5nXL-3L6I79NXtYR3kt-V0bqeqHNfTEFWoyk0&result_types=address";
  /*String fullQuery =
      'https://autocomplete.geocoder.ls.hereapi.com/6.2/suggest.json?apiKey=wCXJuE5nXL-3L6I79NXtYR3kt-V0bqeqHNfTEFWoyk0&query=' +
          query;*/
  final response = await http.get(fullQuery);

  if (response.statusCode == 200) {
    // Serwer zwrocil OK, wiec przekaz obrobionego JSONa
    var responseJson = json.decode(utf8.decode(response.bodyBytes))['items'];
    /*return (responseJson['results'] as List)
        .map((p) => Adresy.fromJson(p))
        .toList();*/
    return (responseJson as List).map((f) => Adres.fromJson(f)).toList();
    /*return responseJson.map((f) {
      return Adres.fromJson(f).toString();
    }).toList();*/
  } else {
    throw Exception('Blad w ladowaniu adresow');
  }
}

class Adres {
  String ulica;
  String numerDomu;
  String miasto;
  int odleglosc;

  Adres({this.ulica, this.numerDomu, this.miasto, this.odleglosc});

  factory Adres.fromJson(Map<String, dynamic> json) {
    return new Adres(
      ulica: json['address']['street'].toString(),
      numerDomu: json['address']['houseNumber'].toString(),
      miasto: json['address']['city'].toString(),
      odleglosc: json['distance'],
    );
  }

  @override
  String toString() {
    String adres = '';

    if (!this.ulica.contains('null')) {
      adres += this.ulica;
    }
    if (!this.numerDomu.contains('null')) {
      adres += (" " + this.numerDomu);
    }
    if (adres == '') {
      adres += this.miasto;
    } else {
      adres += (", " + this.miasto);
    }
    return adres;
  }
}

final _addLocationKey = GlobalKey<FormState>();

class AddLocation extends StatefulWidget {
  @override
  _AddLocationState createState() => _AddLocationState();

  List<Localization> listofLocal;

  AddLocation(this.listofLocal);
}

class _AddLocationState extends State<AddLocation> {
  Completer<GoogleMapController> mapController = Completer();
  Future<List<Adres>> futureAdresy;

  // Funkcja inicjujaca mape
  _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController.complete(controller);
    });
  }

  // Funkcja wywolywana przy ruchu mapa w aplikacji
  _onCameraMove(CameraPosition position) {
    _lastPosition = position.target;
  }

  // Wykonywana tylko przy inicjowaniu + pobranie lokalizacji uzytkownika na starcie
  @override
  void initState() {
    super.initState();
    _getLocation();
    //futureAdresy = fetchAddress('', _initialPosition);
  }

  //Zmienne: kontroler TextField, pozycji na mapie
  var adresController = TextEditingController();
  var nazwaController = TextEditingController();
  final Throttling thrTxt =
      new Throttling(duration: Duration(milliseconds: 500));
  static LatLng _initialPosition;
  static LatLng _lastPosition = _initialPosition;
  Localization dbLokalizacja = new Localization();

  final _formKey = new GlobalKey<FormState>();

  // Dekoracja szaro-zolta
  InputDecoration _buildInputDecoration(String hint, String iconPath) {
    return InputDecoration(
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(252, 252, 252, 1))),
      hintText: hint,
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(151, 151, 151, 1))),
      hintStyle: TextStyle(color: Color.fromRGBO(252, 252, 252, 1)),
      icon: iconPath != '' ? Image.asset(iconPath) : null,
      errorStyle: TextStyle(color: Color.fromRGBO(248, 218, 87, 1)),
      errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(248, 218, 87, 1))),
      focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(248, 218, 87, 1))),
      suffixIcon: hint == 'Adres'
          ? IconButton(
              icon: Icon(Icons.clear), onPressed: () => adresController.clear())
          : null,
    );
  }

  // Dekoracja nowa - granatowa
  InputDecoration _buildInputDecoration2(
      String label, String hint, String iconPath) {
    return InputDecoration(
      //contentPadding: new EdgeInsets.all(5.0),
      filled: true,
      fillColor: new Color(0xFF333366),
      enabledBorder: new OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedBorder: new OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.white),
      ),
      border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.red)),
      labelText: label,
      labelStyle: TextStyle(color: Colors.white),
      hintText: hint,
      suffixIcon: label == 'Adres'
          ? IconButton(
              icon: Icon(Icons.clear), onPressed: () => adresController.clear())
          : null,
    );
  }

// Funkcja zapisuje obecna lokalizacje do zmiennej _initialPosition
  void _getLocation() async {
    Position currentLocation;
    try {
      currentLocation = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    } on PlatformException {
      print('blad w pobraniu lokalizacji');
    }

    setState(() {
      _initialPosition =
          LatLng(currentLocation.latitude, currentLocation.longitude);
    });

    print("Lokalizacja " +
        _initialPosition.latitude.toString() +
        " " +
        _initialPosition.longitude.toString());

    // Przy pierwszym pobraniu lokalizacji zamienia od razu na adres
    locationToAddress();
  }

  // Zamiana lokalizacji na adres - ulica i numer
  void locationToAddress() async {
    final coordinates =
        new Coordinates(_lastPosition.latitude, _lastPosition.longitude);
    var adres = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var adresKrotki = adres.first.addressLine.toString().split(",");

    adresController.text = adresKrotki[0];

    // Zapis do zmiennej bazy danych kodu pocztwoego i najczesciej tez nazwe miasta
    dbLokalizacja.city = adresKrotki[1];
  }

  // Zamiana wprowadzonego tekstu na lokalizacje
  Future<void> addressToLocation(String query) async {
    //final query = adresController.text;
    var adres = await Geocoder.local.findAddressesFromQuery(query);
    var lokalizacja = adres.first.coordinates;
    print("Otrzymana lokalizacja: " + query);
    print(lokalizacja);

    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(lokalizacja.latitude, lokalizacja.longitude),
            zoom: 15.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            color: Color.fromRGBO(51, 47, 83, 1),
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Form(
                key: _formKey,
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildNazwaLokalizacji(),
                      SizedBox(height: 8.0),
                      _buildAdres(),
                      _buildMapa(),
                      _buildDodaj(context)
                    ],
                  ),
                ))),
      ),
    );
  }

// Elementy ekranu
  Widget _buildNazwaLokalizacji() {
    return TextFormField(
      controller: nazwaController,
      validator: (value) =>
          value.isEmpty ? 'Nazwa lokalizacji nie może być pusta' : null,
      style: TextStyle(
          color: Color.fromRGBO(252, 252, 252, 1), fontFamily: 'RadikalLight'),
      decoration: _buildInputDecoration2(
          "Nazwa lokalizacji", "Podaj nazwę nowej lokalizacji", null),
    );
  }

  Widget _buildAdres() {
    return Form(
      child: TypeAheadFormField(
        textFieldConfiguration: TextFieldConfiguration(
          controller: adresController,
          decoration: _buildInputDecoration2("Adres", '', null),
          style: TextStyle(color: Color.fromRGBO(252, 252, 252, 1)),
        ),
        suggestionsCallback: (pattern) {
          if (pattern.isNotEmpty) return fetchAddress(pattern, _lastPosition);
          return null;
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            //contentPadding: EdgeInsets.fromLTRB(10.0, 0, 20.0, 0),
            leading: Icon(Icons.location_on),
            title: Text(suggestion.toString()),
            trailing: Text(suggestion.odleglosc < 1000
                ? (suggestion.odleglosc.toString() + "m")
                : ((suggestion.odleglosc / 1000).toStringAsFixed(1) + "km")),
          );
        },
        transitionBuilder: (context, suggestionsBox, controller) {
          return suggestionsBox;
        },
        onSuggestionSelected: (suggestion) {
          print("Wybrano adres: " + suggestion.toString());
          adresController.text = suggestion.toString();
          addressToLocation(suggestion.toString());
        },
      ),
    );
  }

  Widget _buildMapa() {
    return Container(
        margin: const EdgeInsets.only(top: 25.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        // Nie wyswietli mapy dopóki nie ma lokalizacji użytkownika - zajebiste
        child: _initialPosition == null
            ? Center(
                child: Text('Ładowanie mapy...',
                    style: TextStyle(
                        fontFamily: 'RadikaLight',
                        color: Color.fromRGBO(252, 252, 252, 1))))
            : Stack(children: <Widget>[
                GoogleMap(
                    onMapCreated: _onMapCreated,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    initialCameraPosition:
                        CameraPosition(target: _initialPosition, zoom: 15.0),
                    onCameraMove: _onCameraMove,
                    // Mapa nie ruszana = wyswietl adres
                    onCameraIdle: () {
                      locationToAddress();
                    }),
                Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.flag,
                    color: Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
              ]));
  }

  Widget _buildDodaj(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 35.0),
      width: MediaQuery.of(context).size.width * 0.62,
      child: RaisedButton(
        child: const Text(
          "Dodaj",
          style: TextStyle(
              color: Color.fromRGBO(40, 48, 52, 1),
              fontFamily: 'RadikaMedium',
              fontSize: 14),
        ),
        color: Colors.white,
        elevation: 4.0,
        onPressed: () {
          if (_formKey.currentState.validate()) {
            dbLokalizacja.latitude = _lastPosition.latitude;
            dbLokalizacja.longitude = _lastPosition.longitude;
            dbLokalizacja.name = nazwaController.text;
            dbLokalizacja.street = adresController.text;
            // Miasto zapisane jest w funkcji LocationToAdress()
            // Dodaj do bazy
            //LocalizationHelper.add(dbLokalizacja);
            // Powrot

            widget.listofLocal.add(dbLokalizacja);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
