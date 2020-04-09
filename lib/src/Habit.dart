import 'package:flutter/material.dart';
import 'package:productivity/src/SqlWrapper.dart';

class Habit
{
  int col_id;
  String habit_title;
  String goal_title;
  int freq;

  Habit({this.col_id,this.goal_title,this.habit_title,this.freq});

  Map<String,dynamic> toMap()
  {
    var map = <String,dynamic>{
      HabitsDatabaseProvider.COLUMN_HABIT_TITLE : this.habit_title,
      HabitsDatabaseProvider.COLUMN_GOAL_TITLE : this.goal_title,
      HabitsDatabaseProvider.COLUMN_FREQ : this.freq
    };

    if(this.col_id != null)
    {
      map[HabitsDatabaseProvider.COLUMN_ID] = this.col_id;
    }

    return map;
  }

  static Habit fromMap(Map<String,dynamic> map)
  {
    return Habit(
        col_id: map[HabitsDatabaseProvider.COLUMN_ID],
        habit_title: map[HabitsDatabaseProvider.COLUMN_HABIT_TITLE],
        goal_title: map[HabitsDatabaseProvider.COLUMN_GOAL_TITLE],
        freq: map[HabitsDatabaseProvider.COLUMN_FREQ]
    );
  }
}