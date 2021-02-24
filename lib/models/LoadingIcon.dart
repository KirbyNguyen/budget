import 'package:flutter/material.dart';

dynamic loadingIcon(bool loading, String text) {
  if (loading) {
    return SizedBox(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
        strokeWidth: 2.0,
      ),
      height: 20.0,
      width: 20.0,
    );
  } else {
    return Text(text);
  }
}