import 'package:animation_wrappers/Animations/faded_translation_animation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vroom_user/Auth/loginPage.dart';
import 'package:vroom_user/Components/snackBar.dart';
import 'package:vroom_user/apis/authCall.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscurePassword = true;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
 bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FadedSlideAnimation(
      SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
               
                  Container(
                    child: Image.asset(
                      "assets/resigterPageImage.png",
                      height: 150,
                    ),
                    width: double.infinity,
                  ),
                  Text(
                    "Create Account",
                    style: GoogleFonts.nunitoSans(
                        fontSize: 24.0, color: Colors.white),
                  ),
                  Form(
                     key: _formKey,
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 33.0, vertical: 24),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: fullNameController,
                          decoration: InputDecoration(
                                
                              contentPadding: EdgeInsets.all(0),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.blue,
                              ),
                              labelText: 'Full name',
                              border: OutlineInputBorder()),
                               validator: FormBuilderValidators.minLength(context, 6,
                              errorText: "at least 5 letters"),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: emailController,

                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                                
                              contentPadding: EdgeInsets.all(0),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.blue,
                              ),
                              labelText: 'Email',
                              
                              border: OutlineInputBorder()),
                       validator: FormBuilderValidators.email(context,
                              errorText: 'Incorrect email format'),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: phoneNumberController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                                
                              contentPadding: EdgeInsets.all(0),
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Colors.blue,
                              ),
                              labelText: 'Phone Number',
                              
                              border: OutlineInputBorder()),
                         validator: FormBuilderValidators.compose([
                            FormBuilderValidators.minLength(context, 10,
                                errorText: "Not up to 10 characters")
                          ]),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                            controller: passwordController,
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
                          validator: FormBuilderValidators.minLength(context, 5,
                              errorText: "5 dights at least"),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        // Align(
                        //   child: Text(
                        //     "Forgot Password?",
                        //     style: TextStyle(
                        //       color: Colors.blue,
                        //     ),
                        //   ),
                        //   alignment: Alignment.centerRight,
                        // ),
                        SizedBox(
                          height: 25.0,
                        ),
                          _isLoading
                  ? Container(
                      color: Colors.white,
                      child: Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.blue,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    ):
                        GestureDetector(
                          onTap: (){ if (_formKey.currentState.validate()) {
                          setState(() => _isLoading = true);

                          signUp(
                                  email: emailController.value.text,
                                  name: fullNameController.value.text,
                                  password: passwordController.value.text,
                                  phoneNumber: phoneNumberController.value.text)
                              .then((value) => setState(() => _isLoading = false));
                        } else {
                          showCustomSnackBar('Please fill form correctly');
                        }},
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 50.0,
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                   fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        RichText(
                          text: TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                              children: [
                                TextSpan(
                                  text: "Login",
                                  
                                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Get.to(
                                          () => LoginPage(),
                                        ),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ),
         beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut, 
        ),
      ),
    );
  }
}
