import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:vroom_user/Components/custom_button.dart';
import 'package:vroom_user/Locale/locales.dart';
import 'package:vroom_user/Routes/routes.dart';
import 'package:vroom_user/Theme/colors.dart';

class ConfirmRideRequest extends StatefulWidget {
  @override
  _ConfirmRideRequestState createState() => _ConfirmRideRequestState();
}

class _ConfirmRideRequestState extends State<ConfirmRideRequest> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              child: Icon(Icons.arrow_back),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              locale.confirmRideRequest,
              style: theme.textTheme.headline6,
            ),
          ],
        ),
      ),
      body: FadedSlideAnimation(
        ListView(
          children: [
            ListTile(
              leading: CircleAvatar(
                child: Image.asset('assets/ProfileImages/man5.png'),
              ),
              title: Row(
                children: [
                  Text('David Johnson',
                      style: theme.textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w500,
                      )),
                  SizedBox(
                    width: 8,
                  ),
                  CircleAvatar(
                    radius: 7,
                    child: Icon(
                      Icons.check,
                      color: theme.scaffoldBackgroundColor,
                      size: 12,
                    ),
                    backgroundColor: theme.primaryColor,
                  ),
                ],
              ),
              subtitle: Text(
                'Honda Civic | White',
                style: theme.textTheme.subtitle2,
              ),
              contentPadding:
                  EdgeInsets.only(top: 8, left: 24, right: 24, bottom: 0),
              onTap: () {
                Navigator.pushNamed(context, PageRoutes.riderProfile);
              },
            ),
            Text(
              locale.locations.padLeft(40),
              style: theme.textTheme.subtitle1.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 36,
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: theme.primaryColor,
                    ),
                    Container(
                      width: 1,
                      height: 42,
                      color: hintTextColor,
                    ),
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: secondaryColor,
                    ),
                  ],
                ),
                SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: locale.pickupLocation + ' \n',
                          style: theme.textTheme.subtitle2,
                        ),
                        TextSpan(
                          text: 'Washington Sq. park, New York\n',
                          style: theme.textTheme.bodyText2.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ]),
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: locale.dropLocation + ' \n',
                          style: theme.textTheme.subtitle2,
                        ),
                        TextSpan(
                          text: 'Harison, East Newark, New York',
                          style: theme.textTheme.bodyText2.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
                Spacer(
                  flex: 6,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 4,
              color: Color(0xffE7EAEC),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              locale.dateAndTimings.padLeft(44),
              style: theme.textTheme.subtitle1.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30,
                ),
                Icon(
                  Icons.calendar_today_sharp,
                  color: hintTextColor,
                  size: 16,
                ),
                SizedBox(
                  width: 30,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: locale.date + '\n',
                      style: theme.textTheme.subtitle2,
                    ),
                    TextSpan(
                      text: '22 Feb, 2019',
                      style: theme.textTheme.bodyText2.copyWith(
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                  ]),
                ),
                Spacer(
                  flex: 6,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30,
                ),
                Icon(
                  Icons.access_time_outlined,
                  color: hintTextColor,
                  size: 16,
                ),
                SizedBox(
                  width: 30,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: locale.time + '\n',
                      style: theme.textTheme.subtitle2,
                    ),
                    TextSpan(
                      text: '11:40 pm',
                      style: theme.textTheme.bodyText2.copyWith(
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 4,
              color: Color(0xffE7EAEC),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              locale.fareAndSeatConfirmation.padLeft(54),
              style: theme.textTheme.subtitle1.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30,
                ),
                Icon(
                  Icons.shopping_bag,
                  color: hintTextColor,
                  size: 16,
                ),
                SizedBox(
                  width: 30,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: locale.fare + '\n',
                      style: theme.textTheme.subtitle2,
                    ),
                    TextSpan(
                      text: '\$ 120',
                      style: theme.textTheme.subtitle2.copyWith(
                          fontSize: 15, height: 1.5, color: theme.primaryColor),
                    ),
                  ]),
                ),
                Spacer(
                  flex: 6,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30,
                ),
                Icon(
                  Icons.airline_seat_recline_extra_sharp,
                  color: hintTextColor,
                  size: 16,
                ),
                SizedBox(
                  width: 30,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: locale.numberOfSeats + '\n',
                      style: theme.textTheme.subtitle2,
                    ),
                    TextSpan(
                      text: '2 Seats',
                      style: theme.textTheme.subtitle2.copyWith(
                        fontSize: 15,
                        color: theme.primaryColor,
                        height: 1.5,
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
              label: locale.confirmRequest,
              onTap: () {
                Navigator.pushNamed(context, PageRoutes.fareRate);
              },
              labelStyle: theme.textTheme.headline6,
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
