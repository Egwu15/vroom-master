import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/simple/get_widget_cache.dart';
import 'package:vroom_user/Theme/colors.dart';

// ignore: must_be_immutable
class EntryField extends StatefulWidget {
  final bool readOnly;
  // final String initialValue;
  final Radius borderRadiusTopLeft;
  final Radius borderRadiusTopRight;
  final Radius borderRadiusBottomLeft;
  final Radius borderRadiusBottomRight;
  final String label;
  final EdgeInsets padding;
  final Function validator;
  final TextInputType keyBoardType;
  final TextEditingController controller;
  final bool obsure;
  final Function onChangedFunction;
  EntryField(
      {this.readOnly,
      // this.initialValue,
      this.borderRadiusTopLeft = Radius.zero,
      this.borderRadiusTopRight = Radius.zero,
      this.borderRadiusBottomLeft = Radius.zero,
      this.borderRadiusBottomRight = Radius.zero,
      this.label,
      this.padding,
      this.validator,
      this.keyBoardType,
      this.controller,
      this.obsure,
      this.onChangedFunction});

  @override
  _EntryFieldState createState() => _EntryFieldState();
}

class _EntryFieldState extends State<EntryField> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: widget.borderRadiusTopLeft,
            topRight: widget.borderRadiusTopRight,
            bottomLeft: widget.borderRadiusBottomLeft,
            bottomRight: widget.borderRadiusBottomRight),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 55,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: entryFieldColor,
                ),
                child: Text(
                  widget.label,
                  style:
                      theme.textTheme.bodyText1.copyWith(color: hintTextColor),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 55,
                color: entryFieldColor,
                child: TextFormField(
                  controller: widget.controller,
                  validator: widget.validator,
                  keyboardType: widget.keyBoardType,
                  style: theme.textTheme.bodyText2,
                  obscureText: widget.obsure ?? false,
                  autovalidateMode: AutovalidateMode.always,
                  // initialValue: widget.initialValue,
                  readOnly: widget.readOnly ?? false,
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.end,
                  onChanged: widget.onChangedFunction,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xfff5f4f4),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
