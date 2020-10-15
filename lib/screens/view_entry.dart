import 'package:flutter/material.dart';
import 'package:wasteagram/models/waste.dart';
class ViewEntry extends StatelessWidget {
  static const routeName = "viewEntry";
  @override
  Widget build(BuildContext context) {
    Waste waste = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('WASTE'),),
      body: Center(
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${waste.date}', style: TextStyle(fontSize: 30.0),),
              Image.network('${waste.imageUrl}',
                loadingBuilder: (context, child, progress){
                  return progress == null
                      ? child
                      : LinearProgressIndicator();
                  }
                ),
              Text("Total Waste: ${waste.wasteCount}", style: TextStyle(fontSize: 30.0)),
              Text(waste.shareLocation(), style: TextStyle(fontSize: 20.0))

            ],
          ),
        ),
      ),
    );
  }

}
