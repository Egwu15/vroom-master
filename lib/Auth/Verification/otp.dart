import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../Components/snackBar.dart';

import '../../apis/registrationOtp.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({key}) : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController pinController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String currentText;
  bool _isLoading = false;
  bool _obscurePassword = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    enterOpt() {
      setState(() => _isLoading = true);

      checkOtp((pinController.text)).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              children: [
                SizedBox(height: 150.0),
                Text(
                  'OTP',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                SizedBox(height: 30.0),
                Text("An Otp code has been sent to your email"),
                SizedBox(height: 90.0),
                Text("Enter code"),
                SizedBox(height: 30.0),
                PinCodeTextField(
                  appContext: context,
                  length: 5,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 45,
                      fieldWidth: 45,
                      borderWidth: 1,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      inactiveColor: Colors.grey,
                      selectedFillColor: Colors.white),
                  animationDuration: Duration(milliseconds: 300),
                  // backgroundColor: Colors.blue.shade50,
                  enableActiveFill: true,
                  // errorAnimationController: errorController,
                  controller: pinController,
                  onCompleted: (v) {
                    enterOpt();
                  },
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      currentText = value;
                    });
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                ),
                SizedBox(height: 35.0),
                // Form(key: _formKey,
                //   child: TextFormField(
                //     controller: passwordController,
                //     validator: FormBuilderValidators.minLength(context, 5,
                //         errorText: "5 dights at least"),
                //     decoration: InputDecoration(
                //       suffixIcon: _obscurePassword
                //           ? IconButton(
                //               icon: Icon(Icons.visibility),
                //               onPressed: () => setState(() {
                //                     _obscurePassword = false;
                //                   }))
                //           : IconButton(
                //               icon: Icon(Icons.visibility_off),
                //               onPressed: () => setState(() {
                //                     _obscurePassword = true;
                //                   })),
                //       contentPadding: EdgeInsets.all(0),
                //       prefixIcon: Icon(
                //         Icons.lock,
                //         color: Colors.blue,
                //       ),
                //       labelText: 'new password',
                //       border: OutlineInputBorder(),
                //     ),
                //     obscureText: _obscurePassword,
                //   ),
                // ),
                SizedBox(height: 35.0),
                _isLoading
                    ? CircularProgressIndicator.adaptive()
                    : GestureDetector(
                        onTap: () =>enterOpt(),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 50.0,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Activate account",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
