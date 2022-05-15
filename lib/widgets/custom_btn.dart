import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outlineBtn;
  final bool isLoading;
  final bool colorBackground;
  CustomBtn({
    this.text,
    this.onPressed,
    this.outlineBtn,
    this.isLoading,
    this.colorBackground,
  });
  @override
  Widget build(BuildContext context) {
    bool _outlineBtn = outlineBtn ?? false;
    bool _isLoading = isLoading ?? false;
    bool _colorBackground = colorBackground ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 40.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _outlineBtn ? Colors.redAccent : Colors.black,
          border: Border.all(
            color: _colorBackground ? Colors.redAccent : Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 5.0,
        ),
        child: Stack(
          children: [
            Visibility(
              visible: _isLoading ? false : true,
              child: Center(
                child: Text(
                  text ?? "Text",
                  style: Constants.regularHeading.copyWith(
                    fontSize: 14.0,
                    color: _outlineBtn ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _isLoading,
              child: Center(
                child: SizedBox(
                  height: 30.0,
                  width: 30.0,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
