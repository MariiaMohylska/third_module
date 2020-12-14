import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'app_route.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: MaterialApp(
          color: Colors.purple,
          onUnknownRoute: (settings) => MaterialPageRoute(
        settings: RouteSettings(name: '/error'),
        builder: (context)=>NavigationErrorScreen(
          routeSettings: settings,
        )),
          routes: {
            AppRoute.first: (context) => FirstScreen(),
            AppRoute.second: (context) => SecondScreen(),
          },
        ),
      );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String args = ModalRoute.of(context).settings.arguments;
    return  WillPopScope(
      onWillPop: ()=>showExitDialog(context),
      child: Container(
      color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            FlatButton(
            color: Colors.purple,
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 7.0,
            ),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                AppRoute.second),
              child: Container(
                margin: EdgeInsets.all(16.0),
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 16.0,
                ),
                child: Text("Go next!"),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
              FlatButton(
                color: Colors.purple,
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 7.0,
                ),
                child: GestureDetector(
                  onTap: () {returnedValue(context, args);},
                  child: Container(
                    margin: EdgeInsets.all(16.0),
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 16.0,
                    ),
                    child: Text("Tap to see returned value"),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                  onPressed: null,
                  color: Colors.purple,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 7.0,
                  ),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(AppRoute.first, arguments: '42'),
                    child: Container(
                      margin: EdgeInsets.all(16.0),
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 16.0,
                      ),
                      child: Text("Return 42"),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
              ),
              FlatButton(
                onPressed: null,
                color: Colors.purple,
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 7.0,
                ),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(AppRoute.first, arguments: "AbErVaLlG"),
                  child: Container(
                    margin: EdgeInsets.all(16.0),
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 16.0,
                    ),
                    child: Text("Return AbErVaLlG"),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}

class NavigationErrorScreen extends StatelessWidget{
  final RouteSettings routeSettings;

  const NavigationErrorScreen({Key key, this.routeSettings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("We can`t find page ${routeSettings.name}"),
          GestureDetector(
            onTap: ()=> Navigator.of(context).pop(),
            child: Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16.0,
              ),
              child: Center(
                child: Text("Ok"),
              ),
            ),
          )
        ],
      ),
    );
  }

}

Future<bool> showExitDialog(BuildContext context) async => showDialog<bool>(
  context: context,
  builder: (context) => AlertDialog(
    title: Text("Are you sure?"),
    content: Text("Do you want to exit an app?"),
    actions: <Widget>[
      FlatButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text("Yes"),
      ),
      FlatButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text("No"),
      )
    ],
  )
);

Future<bool> returnedValue(BuildContext context, String value) async => showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Your value"),
      content: Text(value),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text("Ok"),
        ),
      ],
    )
);

