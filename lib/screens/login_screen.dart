import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:strawberry_market/screens/reset_password_screen.dart';
import 'package:strawberry_market/screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  void _login() {
    if (_formKey.currentState!.validate()) {
      _showToast("Logging in...");
    }
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
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 70,
                ),
                BounceInDown(
                  from: 50,
                  child: Image.asset(
                    'assets/images/img_strawberry.png',
                    width: 130,
                    height: 130,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Login to Strawberry',
                  style: GoogleFonts.mukta(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
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
                        maxLength: 20,
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
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            'Forgot your password?',
                            style: GoogleFonts.mukta(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (cnt) => ResetPasswordScreen()));
                            },
                            child: Text(
                              'Restore',
                              style: GoogleFonts.mukta(
                                color: const Color.fromARGB(255, 3, 131, 250),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                decorationColor:
                                    const Color.fromARGB(255, 3, 131, 250),
                                decorationThickness: 4,
                              ),
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
                              SizedBox(
                                width: double.infinity,
                                // height: double.infinity,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.all(16.0),
                                    textStyle: const TextStyle(fontSize: 20),
                                  ),
                                  onPressed: _login,
                                  child: const Text('Sign In'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account? ',
                            style: GoogleFonts.mukta(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (cnt) => SignUpScreen()));
                            },
                            child: Text(
                              'Sign up',
                              style: GoogleFonts.mukta(
                                color: const Color.fromARGB(255, 3, 131, 250),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                decorationColor:
                                    const Color.fromARGB(255, 3, 131, 250),
                                decorationThickness: 4,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/ic_line.png',
                            width: 130,
                            height: 2,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'OR',
                            style: GoogleFonts.mukta(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Image.asset(
                            'assets/images/ic_line.png',
                            width: 130,
                            height: 2,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {}, // Image tapped
                            child: InkWell(
                              onTap: () {
                                _showToast("Sign up with Google");
                              }, // Image tapped
                              splashColor: Colors.white10,
                              child: Ink.image(
                                fit: BoxFit.cover,
                                image: const AssetImage(
                                    'assets/images/ic_telegram.png'),
                                width: 65,
                                height: 65,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              _showToast("Sign up with Telegram");
                            }, // Image tapped
                            splashColor: Colors.white10,
                            child: Ink.image(
                              fit: BoxFit.cover,
                              image: const AssetImage(
                                  'assets/images/ic_google.png'),
                              width: 65,
                              height: 65,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
