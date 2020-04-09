import 'dart:math';

import 'package:flutter/material.dart';

class MyTheme
{
  static Color quote_background = Colors.grey[200];
  static Color light = Colors.teal[300];
  static Color medium = Colors.teal[500];
  static Color dark = Colors.teal[700];
  static Color background = Colors.amber[50];
  static Color fontColor = Colors.white;

  static List<Color> cardColors = [
    light,
    medium
  ];

  static List<Image> goal_icons = [
    Image(image:AssetImage("resources/images/goal_icons/goal1.png")),
    Image(image:AssetImage("resources/images/goal_icons/goal2.png")),
    Image(image:AssetImage("resources/images/goal_icons/goal3.jpg")),
    Image(image:AssetImage("resources/images/goal_icons/goal4.jpg")),
    Image(image:AssetImage("resources/images/goal_icons/goal5.png")),
    Image(image:AssetImage("resources/images/goal_icons/goal6.png")),
    Image(image:AssetImage("resources/images/goal_icons/goal7.jpg")),
  ];

  static List<String> quotes = [
    "If you can dream it, you can do it. \n\n - Walt Disney",
    "The future belongs to those who believe in the beauty of their dreams. \n - Eleanor Roosevelt",
    "Aim for the moon. If you miss, you may hit a star. \n\n - W. Clement Stone",
    "Don’t watch the clock; do what it does. Keep going. \n\n  — Sam Levenson",
    "Keep your eyes on the stars, and your feet on the ground. \n\n — Theodore Roosevelt",
    "We aim above the mark to hit the mark. \n\n - Ralph Waldo Emerson",
    "Change your life today. Don’t gamble on the future, act now, without delay. \n - Simone de Beauvoir",
    "You just can’t beat the person who never gives up. \n\n - Babe Ruth"
  ];

  static Color getCardColor(int i)
  {
    return cardColors[i%cardColors.length];
  }
  static String getQuote()
  {
    var rand = new Random();
    return quotes[rand.nextInt(quotes.length)];
  }
  static int getIndex(int i)
  {
    return i%goal_icons.length;
  }

  static Image getQuoteIcon()
  {
    return Image(image:AssetImage("resources/images/quote_icon/bulb.png"));
  }
}