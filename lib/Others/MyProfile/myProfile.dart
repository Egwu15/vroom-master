import 'package:get/route_manager.dart';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:vroom_user/Components/circularImage.dart';
import 'package:vroom_user/Components/entryFieldForProfile.dart';
import 'package:vroom_user/Components/upload_dialog.dart';
import 'package:vroom_user/Locale/locales.dart';
import 'package:vroom_user/Others/userVerification.dart';
import 'package:vroom_user/Theme/colors.dart';
import 'package:vroom_user/apis/hiveStorage.dart';
import 'package:vroom_user/apis/profileController.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class Reviews {
  final String name;
  final String image;
  final String date;

  Reviews(this.name, this.image, this.date);
}

class _MyProfileState extends State<MyProfile> {
  bool _isloading = false;
  String name = "";
  String email = '';
  HiveCalls hiveCalls = HiveCalls();
  String activeWith = '';
  String phoneNumber = '';
  String profilePic = '';

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    getUserProperties();
    super.initState();
  }

  getUserProperties() async {
    name = await hiveCalls.getUserName();
    email = await hiveCalls.getUserEmail();
    activeWith = await hiveCalls.getActiveWith();
    phoneNumber = await hiveCalls.getPhoneNumber();
    profilePic = await hiveCalls.getProfilePhoto();
    // email = await hiveCalls.getUserEmail();
    print(profilePic);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find();
    var theme = Theme.of(context);
    var locale = AppLocalizations.of(context);
    List<Reviews> _reviews = [
      Reviews(
          'Anthony Smith', 'assets/ProfileImages/man5.png', '15 April,2017'),
      Reviews('Emili Hemilton', 'assets/ProfileImages/women 1.png',
          '15 April,2017'),
      Reviews(
          'Anthony Smith', 'assets/ProfileImages/man2.png', '15 April,2017'),
      Reviews(
          'Anthony Smith', 'assets/ProfileImages/man3.png', '15 April,2017'),
      Reviews(
          'Anthony Smith', 'assets/ProfileImages/man4.png', '15 April,2017'),
    ];
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            locale.myProfile.toUpperCase(),
            style: theme.textTheme.headline6,
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  FadedScaleAnimation(
                    GestureDetector(
                      onTap: () => selectProfilePic(),
                      child: circularImage(profilePic, 70.0),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          name,
                          style: theme.textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     SizedBox(
                      //       width: 20,
                      //     ),
                      //     Icon(
                      //       Icons.star,
                      //       color: secondaryColor,
                      //       size: 16,
                      //     ),
                      //     Icon(
                      //       Icons.star,
                      //       color: secondaryColor,
                      //       size: 16,
                      //     ),
                      //     Icon(
                      //       Icons.star,
                      //       color: secondaryColor,
                      //       size: 16,
                      //     ),
                      //     Icon(
                      //       Icons.star,
                      //       color: secondaryColor,
                      //       size: 16,
                      //     ),
                      //     Icon(
                      //       Icons.star,
                      //       color: secondaryColor,
                      //       size: 16,
                      //     ),
                      //     SizedBox(
                      //       width: 10,
                      //     ),
                      //     Text(
                      //       '(53 ' + locale.reviews + ')',
                      //       style: theme.textTheme.subtitle2,
                      //     ),
                      //   ],
                      // ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: TabBar(
                isScrollable: true,
                labelColor: theme.primaryColor,
                labelPadding: EdgeInsets.symmetric(horizontal: 65),
                unselectedLabelColor: hintTextColor,
                indicatorColor: theme.primaryColor,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(
                    text: locale.about,
                  ),
                  // Tab(
                  //   text: locale.reviews,
                  // ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // first tab bar view widget
                  FadedSlideAnimation(
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 6,
                          color: Color(0xffE7EAEC),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                locale.personalInfo,
                                style: theme.textTheme.bodyText2.copyWith(
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              EntryFieldForProfile(
                                enabled: false,
                                label: locale.emailAddress,
                                initialValue: email,
                                hintText: email,
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 8),
                              ),
                              EntryFieldForProfile(
                                readOnly: true,
                                enabled: false,
                                label: locale.phoneNumber,
                                initialValue: phoneNumber,
                                hintText: phoneNumber,
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 8),
                              ),
                              EntryFieldForProfile(
                                enabled: false,
                                label: "active with",
                                initialValue: activeWith,
                                hintText: activeWith,
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 8),
                              ),
                              //  EntryFieldForProfile(
                              //   enabled: false,
                              //   label: "verify user",
                              //   initialValue: activeWith,
                              //   hintText: activeWith,
                              //   hintStyle: TextStyle(
                              //     color: Colors.black,
                              //   ),

                              // ),

                              // TextButton(
                              //   style: ButtonStyle(
                              //       padding: MaterialStateProperty.all(
                              //           EdgeInsets.all(0))),
                              //   onPressed: () =>
                              //       Get.to(() => UserVerification()),
                              //   child: Text(
                              //     'Verify user',
                              //     style: TextStyle(
                              //       fontSize: 13,
                              //     ),
                              //   ),
                              // ),
                              
                              Divider(height: 20, color: Colors.black45),
                            ],
                          ),
                        ),
                        Spacer(),
                        // Container(
                        //   height: 50,
                        //   width: double.infinity,
                        //   color: theme.primaryColor,
                        //   child: Center(
                        //     child: Text(
                        //       locale.updateInfo,
                        //       style: theme.textTheme.headline6,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    beginOffset: Offset(0, 0.3),
                    endOffset: Offset(0, 0),
                    slideCurve: Curves.linearToEaseOut,
                  ),

                  // second tab bar view widget
                  // FadedSlideAnimation(
                  //   Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Container(
                  //         width: double.infinity,
                  //         height: 4,
                  //         color: Color(0xffE7EAEC),
                  //       ),
                  //       SizedBox(
                  //         height: 20,
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  //         child: Row(
                  //           children: [
                  //             Text(
                  //               '5',
                  //               style: theme.textTheme.bodyText2,
                  //             ),
                  //             SizedBox(
                  //               width: 5,
                  //             ),
                  //             Icon(
                  //               Icons.star,
                  //               color: secondaryColor,
                  //               size: 16,
                  //             ),
                  //             SizedBox(
                  //               width: 10,
                  //             ),
                  //             Expanded(
                  //               child: Container(
                  //                 width: double.infinity,
                  //                 height: 6,
                  //                 decoration: BoxDecoration(
                  //                     gradient: LinearGradient(colors: [
                  //                   theme.primaryColor,
                  //                   Color(0xffE7EAEC),
                  //                 ], stops: [
                  //                   0.6,
                  //                   0.9,
                  //                 ])),
                  //               ),
                  //             ),
                  //             SizedBox(
                  //               width: 10,
                  //             ),
                  //             Text(
                  //               '56',
                  //               style: theme.textTheme.bodyText2,
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  //         child: Row(
                  //           children: [
                  //             Text(
                  //               '4',
                  //               style: theme.textTheme.bodyText2,
                  //             ),
                  //             SizedBox(
                  //               width: 5,
                  //             ),
                  //             Icon(
                  //               Icons.star,
                  //               color: secondaryColor,
                  //               size: 16,
                  //             ),
                  //             SizedBox(
                  //               width: 10,
                  //             ),
                  //             Expanded(
                  //               child: Container(
                  //                 width: double.infinity,
                  //                 height: 6,
                  //                 decoration: BoxDecoration(
                  //                     gradient: LinearGradient(colors: [
                  //                   theme.primaryColor,
                  //                   Color(0xffE7EAEC),
                  //                 ], stops: [
                  //                   0.5,
                  //                   0.7,
                  //                 ])),
                  //               ),
                  //             ),
                  //             SizedBox(
                  //               width: 10,
                  //             ),
                  //             Text(
                  //               '32',
                  //               style: theme.textTheme.bodyText2,
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  //         child: Row(
                  //           children: [
                  //             Text(
                  //               '3',
                  //               style: theme.textTheme.bodyText2,
                  //             ),
                  //             SizedBox(
                  //               width: 5,
                  //             ),
                  //             Icon(
                  //               Icons.star,
                  //               color: secondaryColor,
                  //               size: 16,
                  //             ),
                  //             SizedBox(
                  //               width: 10,
                  //             ),
                  //             Expanded(
                  //               child: Container(
                  //                 width: double.infinity,
                  //                 height: 6,
                  //                 decoration: BoxDecoration(
                  //                     gradient: LinearGradient(colors: [
                  //                   theme.primaryColor,
                  //                   Color(0xffE7EAEC),
                  //                 ], stops: [
                  //                   0.2,
                  //                   0.3,
                  //                 ])),
                  //               ),
                  //             ),
                  //             SizedBox(
                  //               width: 10,
                  //             ),
                  //             Text(
                  //               '10',
                  //               style: theme.textTheme.bodyText2,
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  //         child: Row(
                  //           children: [
                  //             Text(
                  //               '2',
                  //               style: theme.textTheme.bodyText2,
                  //             ),
                  //             SizedBox(
                  //               width: 5,
                  //             ),
                  //             Icon(
                  //               Icons.star,
                  //               color: secondaryColor,
                  //               size: 16,
                  //             ),
                  //             SizedBox(
                  //               width: 10,
                  //             ),
                  //             Expanded(
                  //               child: Container(
                  //                 width: double.infinity,
                  //                 height: 6,
                  //                 decoration: BoxDecoration(
                  //                     gradient: LinearGradient(colors: [
                  //                   theme.primaryColor,
                  //                   Color(0xffE7EAEC),
                  //                 ], stops: [
                  //                   0.3,
                  //                   0.4,
                  //                 ])),
                  //               ),
                  //             ),
                  //             SizedBox(
                  //               width: 10,
                  //             ),
                  //             Text(
                  //               '12',
                  //               style: theme.textTheme.bodyText2,
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  //         child: Row(
                  //           children: [
                  //             Text(
                  //               ' 1',
                  //               style: theme.textTheme.bodyText2,
                  //             ),
                  //             SizedBox(
                  //               width: 5,
                  //             ),
                  //             Icon(
                  //               Icons.star,
                  //               color: secondaryColor,
                  //               size: 16,
                  //             ),
                  //             SizedBox(
                  //               width: 10,
                  //             ),
                  //             Expanded(
                  //               child: Container(
                  //                 width: double.infinity,
                  //                 height: 6,
                  //                 decoration: BoxDecoration(
                  //                     gradient: LinearGradient(colors: [
                  //                   theme.primaryColor,
                  //                   Color(0xffE7EAEC),
                  //                 ], stops: [
                  //                   0.1,
                  //                   0.2,
                  //                 ])),
                  //               ),
                  //             ),
                  //             SizedBox(
                  //               width: 10,
                  //             ),
                  //             Text(
                  //               ' 5',
                  //               style: theme.textTheme.bodyText2,
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 20,
                  //       ),
                  //       Container(
                  //         width: double.infinity,
                  //         height: 4,
                  //         color: Color(0xffE7EAEC),
                  //       ),
                  //       Expanded(
                  //         child: ListView.builder(
                  //             shrinkWrap: true,
                  //             itemCount: _reviews.length,
                  //             itemBuilder: (context, index) {
                  //               return Column(
                  //                 children: [
                  //                   Container(
                  //                     width: double.infinity,
                  //                     height: 4,
                  //                     color: Color(0xffE7EAEC),
                  //                   ),
                  //                   ListTile(
                  //                     leading: CircleAvatar(
                  //                       child:
                  //                           Image.asset(_reviews[index].image),
                  //                     ),
                  //                     title: Row(
                  //                       children: [
                  //                         Text(_reviews[index].name,
                  //                             style: theme.textTheme.bodyText2
                  //                                 .copyWith(
                  //                                     fontWeight:
                  //                                         FontWeight.w500,
                  //                                     height: 3)),
                  //                         Spacer(),
                  //                         Text(
                  //                           _reviews[index].date,
                  //                           style: theme.textTheme.subtitle2,
                  //                         ),
                  //                       ],
                  //                     ),
                  //                     subtitle: Column(
                  //                       children: [
                  //                         Row(
                  //                           children: [
                  //                             Icon(
                  //                               Icons.star,
                  //                               color: secondaryColor,
                  //                               size: 16,
                  //                             ),
                  //                             Icon(
                  //                               Icons.star,
                  //                               color: secondaryColor,
                  //                               size: 16,
                  //                             ),
                  //                             Icon(
                  //                               Icons.star,
                  //                               color: secondaryColor,
                  //                               size: 16,
                  //                             ),
                  //                             Icon(
                  //                               Icons.star,
                  //                               color: secondaryColor,
                  //                               size: 16,
                  //                             ),
                  //                             Icon(
                  //                               Icons.star,
                  //                               color: secondaryColor,
                  //                               size: 16,
                  //                             ),
                  //                           ],
                  //                         ),
                  //                         SizedBox(
                  //                           height: 8,
                  //                         ),
                  //                         Text(
                  //                           'Lorem ipsum dolor sit amet, consectetur adipisicing elit, laboris nisi ut aliquip ex ea commodo consequat.',
                  //                           style: theme.textTheme.subtitle2,
                  //                         ),
                  //                       ],
                  //                     ),
                  //                     contentPadding: EdgeInsets.only(
                  //                         left: 16,
                  //                         right: 16,
                  //                         top: 0,
                  //                         bottom: 8),
                  //                   ),
                  //                 ],
                  //               );
                  //             }),
                  //       ),
                  //     ],
                  //   ),
                  //   beginOffset: Offset(0, 0.3),
                  //   endOffset: Offset(0, 0),
                  //   slideCurve: Curves.linearToEaseOut,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
