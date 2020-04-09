import 'package:flutter/material.dart';
import 'package:productivity/src/SqlWrapper.dart';
class Goal
{
  int goal_id;
  String title;
  String description;

  Goal({this.goal_id,this.title,this.description});

  Map<String,dynamic> toMap()
  {
    var map = <String,dynamic>{
      GoalsDatabaseProvider.COLUMN_GOAL_DES : this.description,
      GoalsDatabaseProvider.COLUMN_GOAL_TITLE : this.title,
    };

    if(this.goal_id != null)
    {
      map[GoalsDatabaseProvider.COLUMN_ID] = this.goal_id;
    }

    return map;
  }

  static Goal fromMap(Map<String,dynamic> map)
  {
    return Goal(
        goal_id: map[GoalsDatabaseProvider.COLUMN_ID],
        title: map[GoalsDatabaseProvider.COLUMN_GOAL_TITLE],
        description: map[GoalsDatabaseProvider.COLUMN_GOAL_DES]
    );
  }
}