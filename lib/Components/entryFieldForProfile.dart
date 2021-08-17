import 'package:flutter/material.dart';
import 'package:vroom_user/Theme/colors.dart';

// ignore: must_be_immutable
class EntryFieldForProfile extends StatefulWidget {
  final String hintText;
  final Color hintColor;
  final String label;
  final Function onTap;
  final EdgeInsetsGeometry padding;
  final TextStyle hintStyle;
  final bool readOnly;
  final num width;
  final EdgeInsets labelFieldPadding;
  final String initialValue;
  final bool enabled;
  EntryFieldForProfile(
      {this.hintText,
      this.hintColor,
      this.label,
      this.padding,
      this.onTap,
      this.hintStyle,
      this.readOnly,
      this.width,
      this.labelFieldPadding,
      this.initialValue,
      this.enabled});

  @override
  _EntryFieldForProfileState createState() => _EntryFieldForProfileState();
}

class _EntryFieldForProfileState extends State<EntryFieldForProfile> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: widget.padding ?? EdgeInsets.all(12.0),
      child: SizedBox(
        width: widget.width ?? MediaQuery.of(context).size.width * 0.9,
        height: 53,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.label != null
                ? Text(
                    widget.label,
                    style: theme.textTheme.subtitle2
                        .copyWith(color: theme.hintColor, fontSize: 12),
                  )
                : SizedBox.shrink(),
            TextFormField(
              style: theme.textTheme.subtitle2
                  .copyWith(fontSize: 13, color: textColor),
              initialValue: widget.initialValue,
              enabled: widget.enabled ?? true,
              
              readOnly: widget.readOnly ?? false,
              onTap: widget.onTap,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: widget.labelFieldPadding,
                hintText: widget.hintText,
                hintStyle: widget.hintStyle ?? theme.textTheme.subtitle2,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
