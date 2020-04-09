import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:productivity/src/Habit.dart';
import 'package:productivity/src/Goal.dart';

class HabitsDatabaseProvider{


  //Database variable
  Database _database;

  //Private constructor
  HabitsDatabaseProvider._();
  static final HabitsDatabaseProvider db = HabitsDatabaseProvider._();


  //Table and column nameS
  static const String TABLE_NAME = "habits";
  static const String COLUMN_ID = "habit_id";
  static const String COLUMN_HABIT_TITLE = "habit_title";
  static const String  COLUMN_GOAL_TITLE = "goal_title";
  static const String COLUMN_FREQ = "freq";

  Future<Database> get database async{

    if(_database != null)
      return _database;

    _database = await _createDatabase();
    return _database;
  }

  Future<Database> _createDatabase() async
  {
    String path = join(await getDatabasesPath(),"HABITSDB.db");
    return await openDatabase(
        path,
        version:1,
        onCreate: (Database db,int version) async {

          //print("creating database");
          db.execute(
            "CREATE TABLE $TABLE_NAME ("
                "$COLUMN_ID INTEGER PRIMARY KEY,"
                "$COLUMN_GOAL_TITLE TEXT,"
                "$COLUMN_HABIT_TITLE TEXT,"
                "$COLUMN_FREQ INTEGER)",
          );
        }
    );
  }

  Future<List<Habit>> getAllHabits() async
  {
    final db = await database;
    print("Starting get all habits query");
    var habits = await db.query(
        TABLE_NAME,
        columns: [COLUMN_ID,COLUMN_GOAL_TITLE,COLUMN_HABIT_TITLE,COLUMN_FREQ],
        groupBy: COLUMN_GOAL_TITLE
    );
    print("Query done");

    List<Habit> habitList = List<Habit>();

    habits.forEach((currentHabit){
      //print("current habit ");
      //print(currentHabit);
      Habit h = Habit.fromMap(currentHabit);
      habitList.add(h);
    });

    print(habitList);
    return habitList;
  }
  Future<List<Habit>> getHabitList(Goal g) async
  {
    final db = await database;
    //print("Starting query");
    var habits = await db.query(
        TABLE_NAME,
        columns: [COLUMN_ID,COLUMN_GOAL_TITLE,COLUMN_HABIT_TITLE,COLUMN_FREQ],
        where : "$COLUMN_GOAL_TITLE = ?",
        whereArgs: [g.title]
    );
    //print("Query done");

    List<Habit> habitList = List<Habit>();

    habits.forEach((currentHabit){
      //print("current habit ");
      //print(currentHabit);
      Habit h = Habit.fromMap(currentHabit);
      habitList.add(h);
    });

    print(habitList);
    return habitList;
  }

  Future<Habit> insert(Habit h) async{
    final db = await database;
    h.col_id = await db.insert(TABLE_NAME,h.toMap());
    //print("Inserting");
    print(h.toMap());
    //print("Inserting a habit");
    return h;
  }

  Future<void> delete(Habit h) async
  {
    final db = await database;
    await db.delete(TABLE_NAME,
        where: "$COLUMN_ID = ?",
        whereArgs: [h.col_id]
    );
  }

  Future<void> deleteAssociatedHabit(Goal g) async
  {
    final db = await database;
    await db.delete(TABLE_NAME,
        where: "$COLUMN_GOAL_TITLE = ?",
        whereArgs: [g.title]
    );
  }
}

class GoalsDatabaseProvider{


  //Database variable
  Database _database;

  //Private constructor
  GoalsDatabaseProvider._();
  static final GoalsDatabaseProvider db = GoalsDatabaseProvider._();


  //Table and column nameS
  static const String TABLE_NAME = "goals";
  static const String COLUMN_ID = "goal_id";
  static const String  COLUMN_GOAL_TITLE = "goal_title";
  static const String  COLUMN_GOAL_DES = "goal_des";

  Future<Database> get database async{

    if(_database != null)
      return _database;

    _database = await _createDatabase();
    return _database;
  }

  Future<Database> _createDatabase() async
  {
    String path = join(await getDatabasesPath(),"GOALSDB.db");
    return await openDatabase(
        path,
        version:1,
        onCreate: (Database db,int version) async {

          //print("creating goals database");
          db.execute(
            "CREATE TABLE $TABLE_NAME ("
                "$COLUMN_ID INTEGER PRIMARY KEY,"
                "$COLUMN_GOAL_TITLE TEXT,"
                "$COLUMN_GOAL_DES TEXT)",
          );
        }
    );
  }

  Future<List<Goal>> getGoalList() async
  {
    final db = await database;
    //print("Starting query");
    var goals = await db.query(
        TABLE_NAME,
        columns: [COLUMN_ID,COLUMN_GOAL_TITLE,COLUMN_GOAL_DES]
    );
    //print("Query done");

    List<Goal> goalList = List<Goal>();

    goals.forEach((currentGoal){
      //print("current habit ");
      //print(currentHabit);
      Goal g = Goal.fromMap(currentGoal);
      goalList.add(g);
    });

    //print(goalList);
    return goalList;
  }

  Future<Goal> insert(Goal g) async{
    final db = await database;
    g.goal_id = await db.insert(TABLE_NAME,g.toMap());
    //print("Inserting");
    //print(g.toMap());
    //print("Inserting a goal");
    return g;
  }

  Future<void> delete(Goal g) async
  {
    final db = await database;
    await db.delete(TABLE_NAME,
        where: "$COLUMN_ID = ?",
        whereArgs: [g.goal_id]
    );

    print("DELTEING HABIT WHEN DELETING GOAL");
    HabitsDatabaseProvider.db.deleteAssociatedHabit(g);
    print("DONE DELETING");
  }
}