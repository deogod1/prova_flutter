import 'package:flutter/material.dart';
import 'package:prova_flutter/application.dart';
import 'package:prova_flutter/injector.dart';

void main() async {
  injectAll();
  runApp(const Application());
}
