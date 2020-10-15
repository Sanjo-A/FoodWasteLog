import 'package:flutter/material.dart';
import 'routes.dart';
class Wasteagram extends StatefulWidget {
  @override
  _WasteagramState createState() => _WasteagramState();
}

class _WasteagramState extends State<Wasteagram> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Wasteagram",
      theme: ThemeData.dark(),
      routes: Routes().appRoutes,
    );
  }
}
