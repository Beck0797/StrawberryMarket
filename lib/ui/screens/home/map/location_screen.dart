import 'dart:async';
import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:strawberry_market/ui/screens/home/map/location_search_screen.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../login/login_screen.dart';
import '../select_categories_screen.dart';
import 'LocationService.dart';
import 'TashkentLocation.dart';

class MapScreen extends StatefulWidget {
  MapScreen({this.suggestionItem, Key? key}) : super(key: key);
  SuggestItem? suggestionItem;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final mapControllerCompleter = Completer<YandexMapController>();
  final List<MapObject> mapObjects = [];
  final MapObjectId cameraMapObjectId = const MapObjectId('camera_placemark');

  var location = "";
  SuggestItem? suggestionItem;

  @override
  void initState() {
    super.initState();
    suggestionItem = widget.suggestionItem;
    _initPermission().ignore();
    if (suggestionItem != null) {
      log("In Location Screen: suggestItem ${suggestionItem!.displayText}");
    }
  }

  Future<void> _initPermission() async {
    if (!await LocationService().checkPermission()) {
      await LocationService().requestPermission();
    }
    await _fetchCurrentLocation();
  }

  Future<void> _fetchCurrentLocation() async {
    AppLatLong location;
    const defLocation = TashkentLocation();
    try {
      location = await LocationService().getCurrentLocation();
    } catch (_) {
      location = defLocation;
    }
    if (suggestionItem == null) {
      _moveToCurrentLocation(location);
    }
  }

  void _updatePlaceMark(Point point) {
    final placemarkMapObject = PlacemarkMapObject(
        mapId: const MapObjectId('search_placemark'),
        point: point,
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage(
            'assets/images/ic_placemark.png',
          ),
        )));

    setState(() {
      mapObjects.add(placemarkMapObject);
    });
  }

  void _goToSelectFavoriteCategories(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (cnt) => const SelectCategoriesScreen()));
    // _showToast("Going to select categories screen");
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<void> _moveToCurrentLocation(
    AppLatLong appLatLong,
  ) async {
    (await mapControllerCompleter.future).moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: appLatLong.lat,
            longitude: appLatLong.long,
          ),
          zoom: 12,
        ),
      ),
    );
  }

  void _goToLoginScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        ModalRoute.withName("/Home"));
  }

  void _goToSearchLocationScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (cnt) => const LocationSearchScreen()));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            _goToLoginScreen(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: FadeInRight(
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Theme.of(context).colorScheme.primary,
                  color: Color.fromARGB(255, 255, 42, 35),
                ),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SizedBox(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Set Location',
                    style: GoogleFonts.mukta(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Please set your location to view nearby listings',
                      style: GoogleFonts.mukta(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 55,
                    child: GestureDetector(
                      onTap: () => _goToSearchLocationScreen(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          maxLength: 35,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            counterText: "",
                            label: const Text('Search or move map'),
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(top: 2),
                              // add padding to adjust icon
                              child: Icon(
                                Icons.search,
                                size: 25,
                              ),
                            ),
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 255, 42, 35),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 159, 150, 144),
                                  width: 2.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 255, 42, 35),
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 255, 42, 35),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().length <= 1 ||
                                value.trim().length > 50 ||
                                !value.contains('@')) {
                              return 'Invalid Email';
                            }
                            location = value;
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          onSaved: (value) {
                            // if (value == null) {
                            //   return;
                            // }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ]),
          ),
          Expanded(
            child: Stack(
              children: [
                YandexMap(
                  mapObjects: mapObjects,
                  onMapCreated: (controller) {
                    mapControllerCompleter.complete(controller);
                    //go to suggested place
                    if (suggestionItem != null) {
                      _updatePlaceMark(Point(
                          latitude: suggestionItem!.center!.latitude,
                          longitude: suggestionItem!.center!.longitude));

                      var selectedLocation = AppLatLong(
                          lat: suggestionItem!.center!.latitude,
                          long: suggestionItem!.center!.longitude);
                      _moveToCurrentLocation(selectedLocation);
                    }
                  },
                  onCameraPositionChanged: (CameraPosition cameraPosition,
                      CameraUpdateReason _, bool __) async {
                    final placemarkMapObject = mapObjects
                            .firstWhere((el) => el.mapId == cameraMapObjectId)
                        as PlacemarkMapObject;

                    setState(() {
                      mapObjects[mapObjects.indexOf(placemarkMapObject)] =
                          placemarkMapObject.copyWith(
                              point: cameraPosition.target);
                    });
                  },
                ),
                Positioned(
                  bottom: 30,
                  right: 0,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: SizedBox(
                      width: double.infinity,
                      // height: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Positioned.fill(
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 255, 42, 35),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              // height: double.infinity,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.all(16.0),
                                  textStyle: const TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  // _login(context);
                                  _goToSelectFavoriteCategories(context);
                                },
                                child: const Text('Done'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
