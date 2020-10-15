import 'package:flutter/material.dart';
import 'package:wasteagram/screens/new_entry.dart';
import 'package:wasteagram/models/waste.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wasteagram/screens/view_entry.dart';
import 'package:intl/intl.dart';
class HomeScreen extends StatefulWidget {
  static const routeName = "/";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List allEntries;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Scaffold(
        
        appBar: AppBar(
            title: checkWasteEntries(context, allEntries)
        ),
        body: checkForEntries(context, allEntries),
        
        floatingActionButton: Semantics(child: FloatingActionButton(
            child: Icon(Icons.add_a_photo),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => NewEntry()
              ));
            },
          ),
          label: 'Create new waste',
          enabled: true,
          button: true,
          onTapHint: 'Move to create new waste page',
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      )
    );
  }
  Widget checkForEntries(BuildContext context, List allEntries){
    return StreamBuilder(
        stream: Firestore.instance.collection('posts').snapshots(),
        builder: (content, snapshot){
          if (snapshot.hasData){
            allEntries = snapshot.data.documents.map((DocumentSnapshot document) {
              if(document['imageUrl'] != null){
                return Waste(
                    imageUrl: document['imageUrl'],
                    longitude: document['longitude'],
                    latitude: document['latitude'],
                    wasteCount: document['quantity'],
                    date: document['date']
                );
              } else{
                return Waste(
                    imageUrl: null,
                    longitude: document['longitude'],
                    latitude: document['latitude'],
                    wasteCount: document['quantity'],
                    date: document['date']
                );
              }
            }).toList();
            allEntries.sort((a,b){
              return b.date.compareTo(a.date);
            });
            return ListView.builder(
                itemCount:snapshot.data.documents.length,
                itemBuilder: (context, index){
                  var post = allEntries[index];
                  return ListTile(
                      leading: Text('${post.wasteCount}', style: TextStyle(fontSize: 20.0)),
                      trailing: Text('${DateFormat('M/d/yy').format(DateTime.parse(post.date))}', style: TextStyle(fontSize:  20.0),),
                      onTap: (){
                        Navigator.of(context).pushNamed(ViewEntry.routeName, arguments: post);
                      }
                  );
                }
            );
          }else{return Center(child: CircularProgressIndicator());}
        }
    );
  }
}



Future <Image> getImage(String uri) async{
  print(uri);
    return Image.network(uri);
}
Widget checkWasteEntries(BuildContext context, List allEntries){
  return allEntries == null
      ? Text('Welcome')
      : getWasteCount(context, allEntries);
}
Widget getWasteCount(BuildContext context, List allEntries){
  var sum = allEntries.fold(0,(previous, current) => previous.wasteCount + current.wasteCount);
  return Text('Total Waste $sum');

}