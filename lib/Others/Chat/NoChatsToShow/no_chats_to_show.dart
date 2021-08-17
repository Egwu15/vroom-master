import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:vroom_user/Locale/locales.dart';
import 'package:vroom_user/Routes/routes.dart';
import 'package:vroom_user/Theme/colors.dart';

class NoChatsToShow extends StatefulWidget {
  @override
  _NoChatsToShowState createState() => _NoChatsToShowState();
}

class _NoChatsToShowState extends State<NoChatsToShow> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(Icons.search),
          ),
        ],
        automaticallyImplyLeading: false,
        title: Text(
          locale.chats.toUpperCase(),
          style: theme.textTheme.headline6,
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, PageRoutes.chats);
        },
        child: FadedScaleAnimation(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/Placeholders/placeholders_chats.png',
                  scale: 1.5,
                ),
              ),
              Text(
                locale.noChatsToShow,
                style: theme.textTheme.headline6.copyWith(
                  color: hintTextColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
