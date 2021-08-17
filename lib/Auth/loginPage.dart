import 'package:animation_wrappers/Animations/faded_translation_animation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vroom_user/Auth/forgotPassword.dart';
import 'package:vroom_user/Auth/registerPage.dart';
import 'package:vroom_user/Components/snackBar.dart';
import 'package:vroom_user/apis/authCall.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FadedSlideAnimation(
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40.0),
                  Container(
                    child: Image.asset(
                      "assets/loginPageImage.png",
                      height: 150,
                    ),
                    width: double.infinity,
                  ),
                  Text(
                    "Welcome Back",
                    style: GoogleFonts.nunitoSans(
                        fontSize: 24.0, color: Colors.blue),
                  ),
                  Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 33.0, vertical: 24),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: emailController,
                              validator: FormBuilderValidators.email(context,
                                  errorText: 'Incorrect email format'),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                              
                                  contentPadding: EdgeInsets.all(0),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.blue,
                                  ),
                                  labelText: 'Email',
                                  border: OutlineInputBorder()),
                            ),
                            SizedBox(
                              height: 25.0,
                            ),
                            TextFormField(
                              controller: passwordController,
                              validator: FormBuilderValidators.minLength(
                                  context, 5,
                                  errorText: "5 dights at least"),
                              decoration: InputDecoration(
                                
                                suffixIcon: _obscurePassword
                                    ? IconButton(
                                        icon: Icon(Icons.visibility),
                                        onPressed: () => setState(() {
                                              _obscurePassword = false;
                                            }))
                                    : IconButton(
                                        icon: Icon(Icons.visibility_off),
                                        onPressed: () => setState(() {
                                              _obscurePassword = true;
                                            })),
                                contentPadding: EdgeInsets.all(0),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.blue,
                                ),
                                labelText: 'password',
                                border: OutlineInputBorder(),
                              ),
                              obscureText: _obscurePassword,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Align(
                              child: GestureDetector(
                                onTap: () => Get.to(() => ForgotPassword()),
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              alignment: Alignment.centerRight,
                            ),
                            SizedBox(
                              height: 25.0,
                            ),
                            _isLoading
                                ? Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: CircularProgressIndicator.adaptive(
                                        backgroundColor: Colors.white,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.blue),
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      if (_formKey.currentState.validate()) {
                                        setState(() => _isLoading = true);

                                        signIn(
                                          email: emailController.value.text,
                                          password:
                                              passwordController.value.text,
                                        ).then((value) =>
                                            setState(() => _isLoading = false));
                                      } else {
                                        showCustomSnackBar(
                                            'Please fill form correctly');
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 50.0,
                                      width: double.infinity,
                                      child: Center(
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              height: 10.0,
                            ),
                            RichText(
                              text: TextSpan(
                                  text: "Dont have account? ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                  children: [
                                    TextSpan(
                                        text: "Sign up",
                                        style: TextStyle(color: Colors.blue),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => Get.to(
                                                () => RegisterPage(),
                                              ))
                                  ]),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            beginOffset: Offset(0, 0.3),
            endOffset: Offset(0, 0),
            slideCurve: Curves.linearToEaseOut,
          ),
        ),
      ),
    );
  }
}
