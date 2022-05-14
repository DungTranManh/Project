import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool isPasswordField;

  CustomInput(
      {this.hintText,
      this.onChanged,
      this.onSubmitted,
      this.focusNode,
      this.textInputAction,
      this.isPasswordField});
  @override
  Widget build(BuildContext context) {
    bool _isPasswordField = isPasswordField ?? false;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 2.0,
      ),
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        border: Border.all(
          color: Colors.white,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TextField(
        focusNode: focusNode,
        onChanged: onChanged,
        obscureText: _isPasswordField,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText ?? "Hint Text ...",
            contentPadding: EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 24.0,
            )),
        style: Constants.regularHeading,
      ),
    );
  }
}
