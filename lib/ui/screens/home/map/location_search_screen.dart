import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:strawberry_market/ui/screens/home/map/location_screen.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class LocationSearchScreen extends StatefulWidget {
  const LocationSearchScreen({super.key});

  @override
  State<LocationSearchScreen> createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  final _formKey = GlobalKey<FormState>();
  var locationText = "";
  List<SuggestItem> suggestionList = List.empty(growable: true);

  Future<void> _searchLocation() async {
    if (_formKey.currentState!.validate()) {
      final resultWithSession = await YandexSuggest.getSuggestions(
              text: locationText,
              boundingBox: const BoundingBox(
                  northEast: Point(
                      latitude: 46.239666266166836,
                      longitude: 75.07959146148595),
                  southWest: Point(
                      latitude: 37.12415016637281,
                      longitude: 54.930667896916766)),
              suggestOptions: const SuggestOptions(
                  suggestType: SuggestType.geo,
                  suggestWords: true,
                  userPosition:
                      Point(latitude: 41.311081, longitude: 69.240562)))
          .result;

      setState(() {
        suggestionList = List.empty(growable: true);
        var cnt = 0;

        for (final element in resultWithSession.items!) {
          if (cnt == 5) {
            break;
          }
          suggestionList.add(element);
          cnt++;

          log(('Item $cnt: ${element.title}'));
          log(('Item $cnt: ${element.displayText}'));
        }
      });
    }
  }

  _sendSuggestionBack(SuggestItem suggestionItem) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => MapScreen(suggestionItem: suggestionItem)),
        ModalRoute.withName("/Map"));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Set location',
          style: GoogleFonts.mukta(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
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
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        FadeInUp(
                          duration: const Duration(milliseconds: 500),
                          child: TextFormField(
                            maxLength: 35,
                            autofocus: true,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              isDense: true,
                              // Added this
                              contentPadding: const EdgeInsets.all(8),
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
                              if (value == null || value.isEmpty) {
                                return 'Enter search key word';
                              } else {
                                locationText = value;
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.search,
                            onSaved: (value) {},
                            onEditingComplete: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              _searchLocation();
                            },
                            onChanged: (value) {
                              _searchLocation();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 700,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: suggestionList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () =>
                              {_sendSuggestionBack(suggestionList[index])},
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  suggestionList[index].title,
                                  style: GoogleFonts.mukta(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  suggestionList[index].displayText,
                                  style: GoogleFonts.mukta(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
