import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:productivity/src/theme.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}



class _HomeState extends State<Home> {

  Widget HomeScreen(BuildContext context)
  {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: MyTheme.background,
        body: SafeArea(
            child: Center(
              child: Padding(
                padding: new EdgeInsets.all(screen_width/20),
                child: Container(
                  width: 18*screen_width/20,
                  height : screen_height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 18*screen_width/40,
                            height: screen_height/4,
                            child: Card(
                              color: MyTheme.light,
                              child: ListTile(
                                title: Center(
                                  child: Text("Goals",
                                    style: TextStyle(
                                        letterSpacing: 1.5,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25
                                    ),),
                                ),
                                onTap: (){
                                  Navigator.pushNamed(context, "/goals");
                                }
                              )
                            ),
                          ),
                          SizedBox(
                            width: 18*screen_width/40,
                            height: screen_height/4,
                            child: Card(
                              color: MyTheme.medium,
                                child: ListTile(
                                  title: Center(
                                      child: Text(
                                          "Habits",
                                          style: TextStyle(
                                            letterSpacing: 1.5,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25
                                          ),
                                      )
                                  ),
                                  onTap: (){
                                    Navigator.pushNamed(context, "/habits");
                                  }
                                )
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screen_height/4,
                        child: Card(
                          color: MyTheme.dark,
                          child: ListTile(
                              title: Center(
                                  child: Text("Progress",
                                    style: TextStyle(
                                        letterSpacing: 1.5,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25
                                    ),)
                              )
                          )

                        ),
                      )
                    ],
                  )
                ),
              ),
            )
        )
    );
  }
  Widget test(BuildContext context)
  {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text(
                    "Goals"
                ),
                onPressed: (){
                  Navigator.pushNamed(context, "/goals");
                },
              ),
              RaisedButton(
                child:Text(
                    "Habits"
                ),
                onPressed: (){
                  Navigator.pushNamed(context, "/habits");
                },
              ),
              RaisedButton(
                child: Text(
                    "Analyze"
                ),
                onPressed: (){
                  Navigator.pushNamed(context, "/analyse");
                },
              ),
            ],
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen(context);
  }
}
