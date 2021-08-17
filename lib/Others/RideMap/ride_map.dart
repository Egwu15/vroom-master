import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:vroom_user/Locale/locales.dart';

class RideMap extends StatefulWidget {
  @override
  _RideMapState createState() => _RideMapState();
}

class _RideMapState extends State<RideMap> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.rideMap,
          style: theme.textTheme.headline6,
        ),
      ),
      body: FadedScaleAnimation(
        Image.asset(
          'assets/map.png',
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }
}
