import 'package:bytebanksalvamentointerno/screens/dashboard.dart';
import 'package:flutter/material.dart';

bool featureItemMatcher(Widget widget, String titulo, IconData icon) {
  if (widget is FeatureItem) {
    return widget.titulo == titulo && widget.icone == icon;
  }
  return false;
}

bool textFildMatcherBylabelText(Widget widget, String labelText) {
  if(widget is TextField) {
    return widget.decoration.labelText ==  labelText;
  }
  return false;
}