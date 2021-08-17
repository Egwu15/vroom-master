import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:vroom_user/Locale/locales.dart';
import 'package:vroom_user/Routes/routes.dart';
import 'package:vroom_user/Theme/colors.dart';

class ListOfRides extends StatefulWidget {
  @override
  _ListOfRidesState createState() => _ListOfRidesState();
}

class InformationOfRides {
  final String image;
  final String name;
  final String numberOfReviews;
  final String price;
  final String numberOfSeatsLeft;
  final String source;
  final String destination;
  final String time;
  final String carName;
  final String carColor;
  InformationOfRides(
      this.image,
      this.name,
      this.numberOfReviews,
      this.price,
      this.numberOfSeatsLeft,
      this.source,
      this.destination,
      this.time,
      this.carName,
      this.carColor);
}

class _ListOfRidesState extends State<ListOfRides> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    var theme = Theme.of(context);

    List<InformationOfRides> _informationOfRides = [
      InformationOfRides(
          'assets/ProfileImages/man1.png',
          'David Johnson',
          '115',
          '15',
          '3',
          'Washington Sq. park, New York',
          'Harison, East Newark, New York',
          '10:00 am',
          'Honda Civic',
          'White'),
      InformationOfRides(
          'assets/ProfileImages/women 1.png',
          'Emili Watson',
          '214',
          '16',
          '3',
          'Washington Union City, New York',
          'Kearny, North Arlington, New York',
          '10:15 am',
          'Toyota Corrola',
          'Red'),
      InformationOfRides(
          'assets/ProfileImages/man3.png',
          'George Smith',
          '99',
          '12',
          '2',
          'Washington Sq. park, New York',
          'Harison, East Newark, New York',
          '10:10 am',
          'Nissan Altima',
          'White'),
      InformationOfRides(
          'assets/ProfileImages/man4.png',
          'Remmy Hemilton',
          '89',
          '18',
          '1',
          'Washington Sq. park, New York',
          'Harison, East Newark, New York',
          '11:00 am',
          'Maruti 800',
          'Black'),
      InformationOfRides(
          'assets/ProfileImages/man5.png',
          'David Johnson',
          '115',
          '15',
          '3',
          'Washington Sq. park, New York',
          'Harison, East Newark, New York',
          '10:00 am',
          'Honda Civic',
          'White'),
      InformationOfRides(
          'assets/ProfileImages/women 1.png',
          'Harshu Makkar',
          '115',
          '15',
          '3',
          'Washington Sq. park, New York',
          'Harison, East Newark, New York',
          '10:00 am',
          'Honda Civic',
          'White'),
      InformationOfRides(
          'assets/ProfileImages/man2.png',
          'David Johnson',
          '115',
          '15',
          '3',
          'Washington Sq. park, New York',
          'Harison, East Newark, New York',
          '10:00 am',
          'Honda Civic',
          'White'),
      InformationOfRides(
          'assets/ProfileImages/man1.png',
          'David Johnson',
          '115',
          '15',
          '3',
          'Washington Sq. park, New York',
          'Harison, East Newark, New York',
          '10:00 am',
          'Honda Civic',
          'White'),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.findARide.toUpperCase(),
          style: theme.textTheme.headline6,
        ),
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        ListView(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: Row(
                        children: [
                          Spacer(),
                          Text(
                            'Washington Sq. park',
                            style: theme.textTheme.subtitle2,
                          ),
                          Spacer(
                            flex: 2,
                          ),
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 16,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '20 June, 2018',
                            style: theme.textTheme.subtitle2,
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: Row(
                        children: [
                          Spacer(),
                          Text(
                            'Harison, East Newark',
                            style: theme.textTheme.subtitle2,
                          ),
                          Spacer(
                            flex: 2,
                          ),
                          Icon(
                            Icons.watch_later_outlined,
                            size: 16,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '10:00 am' + '        ',
                            style: theme.textTheme.subtitle2,
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
                PositionedDirectional(
                  start: 16,
                  top: 22,
                  child: Icon(
                    Icons.swap_vert,
                    color: theme.primaryColor,
                    size: 22,
                  ),
                )
              ],
            ),
            ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _informationOfRides.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: entryFieldColor,
                        height: 8,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Column(
                          children: [
                            ListTile(
                              leading: FadedScaleAnimation(
                                CircleAvatar(
                                  child: Image.asset(
                                      _informationOfRides[index].image),
                                ),
                              ),
                              title: Row(
                                children: [
                                  Text(_informationOfRides[index].name,
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
                              subtitle: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: secondaryColor,
                                    size: 16,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: secondaryColor,
                                    size: 16,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: secondaryColor,
                                    size: 16,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: secondaryColor,
                                    size: 16,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: secondaryColor,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '(' +
                                        _informationOfRides[index]
                                            .numberOfReviews +
                                        ' ' +
                                        locale.reviews +
                                        ')',
                                    style: theme.textTheme.subtitle2,
                                  )
                                ],
                              ),
                              trailing: Column(
                                children: [
                                  Text(
                                    '\$ ' + _informationOfRides[index].price,
                                    style: theme.textTheme.bodyText2.copyWith(
                                        fontWeight: FontWeight.w500,
                                        height: 2.2),
                                  ),
                                  Text(
                                    _informationOfRides[index]
                                            .numberOfSeatsLeft +
                                        ' ' +
                                        locale.seatsLeft,
                                    style: theme.textTheme.subtitle2
                                        .copyWith(fontSize: 12),
                                  ),
                                ],
                              ),
                              contentPadding: EdgeInsets.zero,
                              onTap: () {
                                Navigator.pushNamed(
                                    context, PageRoutes.riderProfile);
                              },
                            ),
                            Row(
                              children: [
                                Spacer(),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 5,
                                      backgroundColor: theme.primaryColor,
                                    ),
                                    Container(
                                      width: 1,
                                      height: 8,
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
                                    Text(
                                      _informationOfRides[index].source,
                                      style: theme.textTheme.subtitle2,
                                    ),
                                    Text(
                                      _informationOfRides[index].destination,
                                      style: theme.textTheme.subtitle2,
                                    ),
                                  ],
                                ),
                                Spacer(
                                  flex: 8,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  _informationOfRides[index].time,
                                  style: theme.textTheme.subtitle2.copyWith(
                                      color: theme.primaryColor,
                                      fontWeight: FontWeight.w800),
                                ),
                                Spacer(),
                                Text(
                                  _informationOfRides[index].carName +
                                      ' | ' +
                                      _informationOfRides[index].carColor,
                                  style: theme.textTheme.subtitle2.copyWith(
                                      color: theme.primaryColor,
                                      fontWeight: FontWeight.w800),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        PageRoutes.confirmRideRequest);
                                  },
                                  child: FadedScaleAnimation(
                                    Container(
                                      width: 85,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        color: theme.primaryColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          locale.request,
                                          style: theme.textTheme.subtitle2
                                              .copyWith(
                                            color:
                                                theme.scaffoldBackgroundColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                })
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
