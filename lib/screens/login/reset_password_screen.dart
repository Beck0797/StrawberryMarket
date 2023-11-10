import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:strawberry_market/screens/login/verify_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  var password = "";

  void _verifyEmail(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _goToVerifyScreen(context);
    }
  }

  void _goToVerifyScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (cnt) => VerifyScreen(
                  verificationCode: "",
                  isSignUp: false,
                  email: "",
                )));
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
            Navigator.pop(context);
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
                    'Forgot your password?',
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
                      'Please enter your email to reset\nyour password!',
                      style: GoogleFonts.mukta(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          maxLength: 35,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            counterText: "",
                            label: const Text('Email Address'),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(top: 2),
                              // add padding to adjust icon
                              child: Image.asset(
                                'assets/images/ic_email.png',
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
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().length <= 1 ||
                                value.trim().length > 50 ||
                                !value.contains('@')) {
                              return 'Invalid Email';
                            }
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
                                      _verifyEmail(context);
                                    },
                                    child: const Text('Continue'),
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
