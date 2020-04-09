import 'package:flutter/material.dart';
import 'package:productivity/src/Habit.dart';
import 'package:productivity/src/SqlWrapper.dart';
import 'package:productivity/src/theme.dart';


class Habits extends StatefulWidget {
  @override
  _HabitsState createState() => _HabitsState();
}

class _HabitsState extends State<Habits> {

  List<Habit> habit_list;
  static List<bool> _visible = List.generate(1000, (int i) => false);
  Future fetchHabits() async
  {
    //Get habits associated with the goal
    habit_list = await HabitsDatabaseProvider.db.getAllHabits();
    return habit_list;
  }


  Widget habitWidget()
  {
    return FutureBuilder(
        future: fetchHabits(),
        builder: (BuildContext context,projectSnap){
          if (projectSnap.connectionState == ConnectionState.none &&
              projectSnap.hasData == null) {
            return CircularProgressIndicator();
          }
          return updatedScreen();
        }
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

    if(habit_list == null)
      return CircularProgressIndicator();

    return Scaffold(
        backgroundColor: MyTheme.background,
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              quoteOfDay(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal:1),
                child: Center(
                    child: Text(
                      "Your Habits!",
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
                  itemCount: habit_list.length,
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
                              habit_list[index].habit_title,
                              style: TextStyle(
                                letterSpacing: 1.5,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: MyTheme.fontColor,
                              ),
                            ),
                            subtitle: Text(
                              habit_list[index].goal_title == null? "NONE": habit_list[index].goal_title,
                              style: TextStyle(
                                color: MyTheme.fontColor,
                              ),
                            ),
                            leading: MyTheme.goal_icons[MyTheme.getIndex(index)],
                            trailing: Visibility(
                                visible: _visible[index],
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 50,
                                ),
                            ),
                            onTap: (){
                              setState(() {
                                _visible[index] = !_visible[index];
                                print(_visible[index]);
                              });
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Switch(
                value:true,
                onChanged: (bool e){
                  Navigator.pop(context);
                },
                activeColor: MyTheme.medium,
                inactiveTrackColor: Colors.amber,
                inactiveThumbColor: Colors.amber,

              ),
              Center(
                child: Text(
                  "Switch back to Goal screen",
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
  @override
  Widget build(BuildContext context) {
    return habitWidget();
  }
}
