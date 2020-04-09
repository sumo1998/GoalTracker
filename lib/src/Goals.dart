import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:productivity/src/Goal.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:productivity/src/SqlWrapper.dart';
import 'package:productivity/src/Habit.dart';
import 'dart:async';

import 'package:productivity/src/theme.dart';

class Goals extends StatefulWidget {
  @override
  _GoalsState createState() => _GoalsState();
}

class _GoalsState extends State<Goals> {



  static List<Goal> goalList;


  void _showAddHabitDialog(Goal g) async
  {
    TextEditingController ctr = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {

          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.5)
            ),
            child: Container(
              color: MyTheme.quote_background,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical:25.0,horizontal:10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Add Habit",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 1.3,
                    ),),
                    Container(
                        width: 200,
                        child: TextField(
                          controller: ctr,
                          cursorColor: Colors.teal[600],
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                            child:Text("Add Habit"),
                            onPressed:() async{
                              Habit h = Habit(goal_title:g.title,habit_title:ctr.text,freq:7);
                              h = await HabitsDatabaseProvider.db.insert(h);
                              Fluttertoast.showToast(msg: "Added");
                              Navigator.pop(context);
                            }
                        ),
                        FlatButton(
                          child:Text("Cancel"),
                          onPressed:(){
                            Navigator.pop(context);
                          }
                        )
                      ]
                    )
                  ],
                ),
              )
            ),
          );
        }
    );
  }

  void _listHabitsDialog(Goal g) async
  {
    //Get habits associated with the goal
    List<Habit> h_list = await HabitsDatabaseProvider.db.getHabitList(g);
    print("Got a result for query");
    showDialog(
      context: context,
      builder: (BuildContext context){
        return Dialog(
          child: Container(
              height:300,
              child: SingleChildScrollView(
                  child:ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 100),
                    child: Column(
                      children: <Widget>[
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: h_list.length,
                            itemBuilder: (BuildContext,index){
                              return Card(
                                  child:ListTile(
                                    title: Text(h_list[index].habit_title),
                                    subtitle: Text(h_list[index].goal_title),
                                    leading: MyTheme.goal_icons[MyTheme.getIndex(index)],
                                    onTap: () async{
                                      await HabitsDatabaseProvider.db.delete(h_list[index]);
                                      print("deleted");
                                      Navigator.pop(context);
                                    },
                                  )
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )
              )
          )
        );
      });
  }

  Future fetchGoals() async {
    print("Fetching initial goals");
    goalList = await GoalsDatabaseProvider.db.getGoalList();
    return goalList;
  }

  Widget goalWidget()
  {
    return FutureBuilder(
      future: fetchGoals(),
      builder: (BuildContext context,projectSnap){
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          return CircularProgressIndicator();
        }
        return updatedScreen();
      }
    );
  }
  void _showAddGoalDialog() async
  {
    TextEditingController ctr_title = TextEditingController();
    TextEditingController ctr_des = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {

          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.5),
            ),
            child: Container(
                height: 230,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical:25.0,horizontal:10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("Add a Goal"),
                        Container(
                            width: 200,
                            child: TextField(
                              controller: ctr_title,
                            )),
                        Container(
                            width: 200,
                            child: TextField(
                              controller: ctr_des,
                            )),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              FlatButton(
                                  child:Text("Add Goal"),
                                  onPressed:() async{
                                    Goal g = Goal(title:ctr_title.text,description:ctr_des.text);
                                    g = await GoalsDatabaseProvider.db.insert(g);
                                    goalList = await GoalsDatabaseProvider.db.getGoalList();
                                    Fluttertoast.showToast(msg: "Added");
                                    Navigator.pop(context);

                                    setState((){
                                    });
                                  }
                              ),
                              FlatButton(
                                  child:Text("Cancel"),
                                  onPressed:(){
                                    Navigator.pop(context);
                                  }
                              )
                            ]
                        )
                      ],
                    ),
                  ),
                )
            ),
          );
        }
    );
  }

  Widget emptyScreen()
  {
    return Scaffold(
        floatingActionButton: Transform.scale(
          scale: 1.25,
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: FloatingActionButton(
              child: Text(
                "+",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              tooltip: "Add a Goal",
              onPressed: (){
                _showAddGoalDialog();
              },
            ),
          ),
        )
    );
  }

  Widget quoteOfDay()
  {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      child: Container(
          height: screen_height/5,
          child: Card(
              color: MyTheme.medium,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.5)
              ),
              child: ListTile(
                isThreeLine: true,
                leading: MyTheme.getQuoteIcon(),
                title: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    "Quote of the day",
                    style: TextStyle(
                      letterSpacing: 1.2,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    MyTheme.getQuote(),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
          )
      ),
    );
  }

  Widget updatedScreen()
  {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;

    if(goalList == null)
      return CircularProgressIndicator();

    return Scaffold(
      backgroundColor: MyTheme.background,
      resizeToAvoidBottomPadding: false,
      floatingActionButton: Transform.scale(
        scale: 1.15,
        child: FloatingActionButton(
          backgroundColor: MyTheme.medium,
          child: Text(
            "+",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          tooltip: "Add a Goal",
          onPressed: (){
            _showAddGoalDialog();
          },
        ),
      ),
      body: SafeArea(
          child: Column(
            children: <Widget>[
              quoteOfDay(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal:1),
                child: Center(
                    child: Text(
                      "Your Goals!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.3
                      ),
                    )
                ),
              ),
              Container(
                padding: new EdgeInsets.symmetric(vertical: 2,horizontal: 1),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: MyTheme.dark,
                    width: 2.4
                  )
                ),
                height: screen_height/2,
                  width:screen_width/1.1,
                  child: ListView.builder(
                    itemCount: goalList.length,
                    itemBuilder: (BuildContext,index){
                      return SizedBox(
                        height: screen_height/6,
                        child: Container(
                          padding: new EdgeInsets.symmetric(vertical:2,horizontal: 5),
                          child: Card(
                            color: MyTheme.getCardColor(index),
                            child: ListTile(
                              isThreeLine: true,
                              title: Text(
                                goalList[index].title,
                                style: TextStyle(
                                    letterSpacing: 1.5,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  color: MyTheme.fontColor,
                                ),
                              ),
                              subtitle: Text(
                                  goalList[index].description == null? "NONE": goalList[index].description,
                                style: TextStyle(
                                  color: MyTheme.fontColor,
                                ),
                              ),
                              leading: MyTheme.goal_icons[MyTheme.getIndex(index)],
                              trailing: PopupMenuButton(
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 1,
                                    child: Text("Associate a habit"),
                                  ),
                                  PopupMenuItem(
                                    value: 2,
                                    child: Text("De-associate a habit"),
                                  ),
                                  PopupMenuItem(
                                    value: 3,
                                    child: Text("Delete goal"),
                                  ),
                                ],
                                onSelected: (value){
                                  switch(value)
                                  {
                                    case 1: Fluttertoast.showToast(
                                        msg: " Add habit"
                                    );
                                    _showAddHabitDialog(goalList[index]);
                                    break;
                                    case 2: Fluttertoast.showToast(
                                        msg : " Delete haibit"
                                    );
                                    _listHabitsDialog(goalList[index]);
                                    break;
                                    case 3: Fluttertoast.showToast(
                                        msg : "Delete goal"
                                    );
                                    GoalsDatabaseProvider.db.delete(goalList[index]);
                                    setState(() {

                                    });
                                    break;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              Switch(
                value: false,
                onChanged: (bool e){
                  Navigator.pushNamed(context, "/habits");
                },
                activeColor: MyTheme.medium,
                inactiveTrackColor: Colors.amber,
              ),
              Center(
                child: Text(
                    "Switch to Habits screen",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      letterSpacing: 1.3
                  ),
                ),
              )
            ],
          ),

          )

    );
  }

  List<String> popupList = ["Associate a habit","De-associate a habit","Delete habit"];


  @override
  Widget build(BuildContext context) {

    return goalWidget();
  }
}
