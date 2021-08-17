import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vroom_user/Components/custom_button.dart';
import 'package:vroom_user/Components/textField.dart';
import 'package:vroom_user/Locale/locales.dart';
import 'package:vroom_user/Routes/routes.dart';
import 'package:vroom_user/Theme/colors.dart';

class FindARide extends StatefulWidget {
  @override
  _FindARideState createState() => _FindARideState();
}

class _FindARideState extends State<FindARide> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration(seconds: 1),
        () => showDialog(
              context: context,
              builder: (BuildContext context) => _buildPopupDialog(context),
            ));
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    var theme = Theme.of(context);
    return Stack(
      children: [
        Image.asset(
          'assets/Ride.png',
          fit: BoxFit.fill,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        PositionedDirectional(
          top: 60,
          start: 30,
          child: FadedScaleAnimation(
            Text(
              locale.findARide.toUpperCase(),
              style: theme.textTheme.headline6,
            ),
          ),
        ),
        PositionedDirectional(
          top: 130,
          start: 10,
          end: 0,
          child: Stack(
            children: [
              FadedScaleAnimation(
                Column(
                  children: [
                    TextInput(
                      hintText: locale.pickupLocation,
                      borderRadiusTopLeft: Radius.circular(12),
                      borderRadiusTopRight: Radius.circular(12),
                      width: MediaQuery.of(context).size.width * 0.85,
                      prefixIcon: Icon(
                        Icons.circle,
                        color: theme.primaryColor,
                        size: 16,
                      ),
                    ),
                    TextInput(
                      hintText: locale.dropLocation,
                      width: MediaQuery.of(context).size.width * 0.85,
                      borderRadiusBottomLeft: Radius.circular(12),
                      borderRadiusBottomRight: Radius.circular(12),
                      prefixIcon: Icon(
                        Icons.circle,
                        color: secondaryColor,
                        size: 16,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextInput(
                      hintText: locale.dateAndTimings,
                      borderRadiusBottomRight: Radius.circular(12),
                      borderRadiusTopLeft: Radius.circular(12),
                      borderRadiusTopRight: Radius.circular(12),
                      borderRadiusBottomLeft: Radius.circular(12),
                      prefixIcon: Icon(
                        Icons.calendar_today_outlined,
                        size: 22,
                      ),
                      width: MediaQuery.of(context).size.width * 0.85,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextInput(
                      hintText: locale.selectNumberOfSeats,
                      borderRadiusBottomRight: Radius.circular(12),
                      borderRadiusTopLeft: Radius.circular(12),
                      borderRadiusTopRight: Radius.circular(12),
                      borderRadiusBottomLeft: Radius.circular(12),
                      width: MediaQuery.of(context).size.width * 0.85,
                      prefixIcon: Icon(
                        Icons.person,
                        size: 22,
                      ),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down_sharp,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
              PositionedDirectional(
                start: 39,
                top: 32,
                child: Container(
                  width: 1,
                  height: 45,
                  color: hintTextColor,
                ),
              )
            ],
          ),
        ),
        PositionedDirectional(
          bottom: 20,
          start: 0,
          end: 0,
          child: FadedScaleAnimation(
            CustomButton(
              label: locale.searchRides,
              onTap: () {
                Navigator.pushNamed(context, PageRoutes.listOfRides);
              },
              height: 55,
              labelStyle: theme.textTheme.subtitle1
                  .copyWith(color: theme.scaffoldBackgroundColor),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  var theme = Theme.of(context);
  var locale = AppLocalizations.of(context);

  return new AlertDialog(
    contentPadding: EdgeInsets.zero,
    content: FadedSlideAnimation(
      new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ClipRRect(
            child: Image.asset(
              'assets/Icons/referNow.png',
              width: 300,
              height: 150,
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              locale.doYouHaveAnyReferralCode,
              style: theme.textTheme.headline6
                  .copyWith(color: theme.primaryColor, letterSpacing: 0),
            ),
          ),
          TextInput(
            hintText: locale.addSixDigitReferralCode,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Text(
                    locale.iDontHave,
                    style: theme.textTheme.headline6
                        .copyWith(color: textColor, letterSpacing: 0),
                  ),
                  Spacer(),
                  Text(
                    locale.cont,
                    style: theme.textTheme.headline6
                        .copyWith(color: theme.primaryColor, letterSpacing: 0),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      beginOffset: Offset(0, 0.3),
      endOffset: Offset(0, 0),
      slideCurve: Curves.linearToEaseOut,
    ),
  );
}
