import 'package:flutter/material.dart';
import 'package:productivity/src/Home.dart';
import 'package:productivity/src/Goals.dart';
import 'package:productivity/src/Analyse.dart';
import 'package:productivity/src/Habits.dart';

void main() => runApp(
  MaterialApp(
      initialRoute: "/goals",
      routes: {
        "/home" : (context) => Home(),
        "/habits" : (context) => Habits(),
        "/goals" : (context) => Goals(),
        "/analyse" : (context) => Analyse()
      }
  )
);

