import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Function onPressed;
  final String label;
  final EdgeInsets padding;

  const PrimaryButton({
    Key key,
    this.onPressed,
    this.label,
    this.padding = const EdgeInsets.only(top: 40.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label?.toUpperCase() ?? ''),
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(52.0),
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
    );
  }
}
