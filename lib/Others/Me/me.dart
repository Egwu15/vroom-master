import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/instance_manager.dart';
import 'package:vroom_user/Auth/loginPage.dart';
import 'package:vroom_user/Components/circularImage.dart';
import 'package:vroom_user/Components/custom_button.dart';
import 'package:vroom_user/Components/snackBar.dart';
import 'package:vroom_user/Locale/locales.dart';
import 'package:vroom_user/Routes/routes.dart';
import 'package:vroom_user/Theme/colors.dart';
import 'package:vroom_user/apis/checkOrderStatus.dart';
import 'package:vroom_user/apis/hiveStorage.dart';
import 'package:vroom_user/apis/profileController.dart';
import 'package:vroom_user/apis/quotation.dart';
import 'package:get/route_manager.dart';

class Me extends StatefulWidget {
  @override
  _MeState createState() => _MeState();
}

class AccountItems {
  final String title;
  final Widget icon;

  AccountItems(this.title, this.icon);
}

bool _isloading = false;
String name = "";
HiveCalls hiveCalls = HiveCalls();
String profilePic = "";

class _MeState extends State<Me> {
  @override
  void initState() {
    super.initState();
    getUserProperties();
  }

  getUserProperties() async {
    name = await hiveCalls.getUserName();
    profilePic = await hiveCalls.getProfilePhoto();
    // email = await hiveCalls.getUserEmail();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find();
    var theme = Theme.of(context);
    var locale = AppLocalizations.of(context);
    List<AccountItems> _accountItems = [
      AccountItems(
          locale.myProfile,
          FadedScaleAnimation(
            Icon(
              Icons.person,
              color: theme.primaryColor,
            ),
          )),
      AccountItems(
          locale.notifications,
          FadedScaleAnimation(
            Icon(
              Icons.notifications,
              color: theme.primaryColor,
            ),
          )),
      AccountItems(
          'Check for quotation',
          FadedScaleAnimation(
            Icon(
              Icons.quickreply_outlined,
              color: theme.primaryColor,
            ),
          )),
      AccountItems(
          "Check order Status",
          FadedScaleAnimation(
            Icon(
              Icons.sports_golf_outlined,
              color: theme.primaryColor,
            ),
          )),
      AccountItems(
          "Make payment",
          FadedScaleAnimation(
            Icon(
              Icons.payment,
              color: theme.primaryColor,
            ),
          )),
      AccountItems(
          locale.termsAndConditions,
          FadedScaleAnimation(
            Icon(
              Icons.list_alt_outlined,
              color: theme.primaryColor,
            ),
          )),
      AccountItems(
          locale.referAndEarn,
          FadedScaleAnimation(
            Icon(
              Icons.share,
              color: theme.primaryColor,
            ),
          )),
      AccountItems(
          locale.rateVroom,
          FadedScaleAnimation(
            Icon(
              Icons.thumb_up,
              color: theme.primaryColor,
            ),
          )),
      AccountItems(
          locale.changeLanguage,
          FadedScaleAnimation(
            Icon(
              Icons.language,
              color: theme.primaryColor,
            ),
          )),
      AccountItems(
          locale.help,
          FadedScaleAnimation(
            Icon(
              Icons.help,
              color: theme.primaryColor,
            ),
          )),
    ];
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "me".toUpperCase(),
            style: theme.textTheme.headline6,
          ),
        ),
        body: !_isloading
            ? ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        FadedScaleAnimation(
                          circularImage(profilePic, 70.0),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                name,
                                style: theme.textTheme.bodyText1.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            // // Row(
                            // //   children: [
                            // //     SizedBox(
                            // //       width: 20,
                            // //     ),
                            // //     Icon(
                            // //       Icons.star,
                            // //       color: secondaryColor,
                            // //       size: 16,
                            // //     ),
                            // //     Icon(
                            // //       Icons.star,
                            // //       color: secondaryColor,
                            // //       size: 16,
                            // //     ),
                            // //     Icon(
                            // //       Icons.star,
                            // //       color: secondaryColor,
                            // //       size: 16,
                            // //     ),
                            // //     Icon(
                            // //       Icons.star,
                            // //       color: secondaryColor,
                            // //       size: 16,
                            // //     ),
                            // //     Icon(
                            // //       Icons.star,
                            // //       color: secondaryColor,
                            // //       size: 16,
                            // //     ),
                            // //     SizedBox(
                            // //       width: 10,
                            // //     ),
                            // //     Text(
                            // //       '(53 ' + locale.reviews + ')',
                            // //       style: theme.textTheme.subtitle2,
                            // //     ),
                            // //   ],
                            // ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 4,
                    color: Color(0xffE7EAEC),
                  ),
                  ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _accountItems.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: index == 0
                              ? () {
                                  Navigator.pushNamed(
                                      context, PageRoutes.myProfile);
                                }
                              : index == 9
                                  ? () {
                                      Navigator.pushNamed(
                                          context, PageRoutes.help);
                                    }
                                  : index == 5
                                      ? () {
                                          Navigator.pushNamed(context,
                                              PageRoutes.termsAndConditions);
                                        }
                                      : index == 6
                                          ? () {
                                              Navigator.pushNamed(
                                                  context, PageRoutes.referNow);
                                            }
                                          : index == 1
                                              ? () {
                                                  Navigator.pushNamed(context,
                                                      PageRoutes.notifications);
                                                }
                                              : index == 8
                                                  ? () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          PageRoutes
                                                              .changeLanguage);
                                                    }
                                                  : index == 3
                                                      ? () {
                                                          setState(() {
                                                            _isloading = true;
                                                          });
                                                          checkOrderStatus()
                                                              .then((_) {
                                                            setState(() {
                                                              _isloading =
                                                                  false;
                                                            });
                                                          });
                                                        }
                                                      : index == 2
                                                          ? () {
                                                              setState(() {
                                                                _isloading =
                                                                    true;
                                                              });
                                                              checkForQuotaton()
                                                                  .then(
                                                                      (value) {
                                                                if (value ==
                                                                    false) {
                                                                  showCustomSnackBar(
                                                                      "No quotation avaliable!");
                                                                }
                                                                setState(() {
                                                                  _isloading =
                                                                      false;
                                                                });
                                                              });
                                                            }
                                                          : index == 4
                                                              ? () {
                                                                  setState(() {
                                                                    _isloading =
                                                                        true;
                                                                  });
                                                                  makePayment()
                                                                      .then(
                                                                          (_) {
                                                                    setState(
                                                                        () {
                                                                      _isloading =
                                                                          false;
                                                                    });
                                                                  });
                                                                }
                                                              : () {},
                          leading: _accountItems[index].icon,
                          title: Text(
                            _accountItems[index].title,
                            style: theme.textTheme.bodyText1.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }),
                  Container(
                    width: double.infinity,
                    height: 4,
                    color: Color(0xffE7EAEC),
                  ),
                  CustomButton(
                    onTap: () {
                      Get.off(() => LoginPage());
                    },
                    bgColor: theme.scaffoldBackgroundColor,
                    labelStyle: theme.textTheme.headline6.copyWith(
                        color: theme.primaryColor, fontWeight: FontWeight.w500),
                    label: locale.logout,
                    height: 40,
                  ),
                  Container(
                    width: double.infinity,
                    height: 4,
                    color: Color(0xffE7EAEC),
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator.adaptive(),
              ));
  }
}
