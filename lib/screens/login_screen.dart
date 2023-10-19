import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 70,
            ),
            Image.asset(
              'assets/images/img_strawberry.png',
              width: 130,
              height: 130,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Login to Strawberry',
              style: GoogleFonts.mukta(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 36,
              ),
            ),
            const SizedBox(
              height: 49,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    maxLength: 50,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
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
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length <= 1 ||
                          value.trim().length > 50) {
                        return 'Must be between 1 and 50 characters.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // if (value == null) {
                      //   return;
                      // }
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    maxLength: 50,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
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
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length <= 1 ||
                          value.trim().length > 50) {
                        return 'Must be between 1 and 50 characters.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // if (value == null) {
                      //   return;
                      // }
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        'Forgot your password?',
                        style: GoogleFonts.mukta(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Restore',
                        style: GoogleFonts.mukta(
                          color: const Color.fromARGB(255, 3, 131, 250),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          decorationColor:
                              const Color.fromARGB(255, 3, 131, 250),
                          decorationThickness: 4,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
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
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.all(16.0),
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            onPressed: () {},
                            child: const Text('Login'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account? ',
                        style: GoogleFonts.mukta(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Sign up',
                        style: GoogleFonts.mukta(
                          color: const Color.fromARGB(255, 3, 131, 250),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          decorationColor:
                              const Color.fromARGB(255, 3, 131, 250),
                          decorationThickness: 4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ]),
    );
  }
}
