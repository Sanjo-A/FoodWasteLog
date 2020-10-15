import 'package:flutter/material.dart';
import 'screens/new_entry.dart';
import 'screens/view_entry.dart';
import 'screens/home.dart';

class Routes{
  var appRoutes = <String, WidgetBuilder>{
    HomeScreen.routeName: (context) => HomeScreen(),
    NewEntry.routeName: (context) => NewEntry(),
    ViewEntry.routeName:(context) => ViewEntry(),
  };
}