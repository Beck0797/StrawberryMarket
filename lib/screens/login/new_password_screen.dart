import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:strawberry_market/screens/login/login_screen.dart';
import 'package:strawberry_market/screens/login/verify_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

class NewPasswordScreen extends StatelessWidget {
  NewPasswordScreen({super.key, required this.email});

  final _formKey = GlobalKey<FormState>();
  var password = "";
  var email = "";

  void _updatePassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _resetPassword(context);
    }
  }

  Future<void> _resetPassword(context) async {
    if (_formKey.currentState!.validate()) {
      final url =
          Uri.http('13.125.246.40:8080', '/api/v1/users/reset-password');
      var response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'email': email,
            'newPassword': password,
            'confirmNewPassword': password,
          },
        ),
      );

      final Map parsed = json.decode(response.body);
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Request result: ${response.body}');
        }
        _showToast(parsed["message"].toString());

        _goToLoginScreen(context);
      } else {
        _showToast(parsed["message"].toString());
        print('response: ${response.body}.');
      }
    }
  }

  void _goToLoginScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        ModalRoute.withName("/Home"));
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
                  Text(
                    'Update password',
                    style: GoogleFonts.mukta(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Enter new password!',
                      style: GoogleFonts.mukta(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          maxLength: 10,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            counterText: "",
                            label: const Text('Password'),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(top: 2),
                              // add padding to adjust icon
                              child: Image.asset(
                                'assets/images/ic_password.png',
                                width: 25,
                                height: 25,
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
                              return 'Invalid Password';
                            } else if (value.trim().length < 6 ||
                                value.trim().length > 10) {
                              return 'Must be between 6 and 10 characters.';
                            }
                            password = value!;
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          onSaved: (value) {
                            // if (value == null) {
                            //   return;
                            // }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          maxLength: 10,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            counterText: "",
                            label: const Text('Confirm Password'),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(top: 2),
                              // add padding to adjust icon
                              child: Image.asset(
                                'assets/images/ic_password.png',
                                width: 25,
                                height: 25,
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
                            if (value != password) {
                              return 'password does not match';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.done,
                          onSaved: (value) {
                            // if (value == null) {
                            //   return;
                            // }
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
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
                                      _updatePassword(context);
                                    },
                                    child: const Text('Update Password'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
