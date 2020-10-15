import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location/location.dart';
import 'dart:io';

class NewEntry extends StatefulWidget {
  static const routeName = "newEntry";

  @override
  _NewEntryState createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  final formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  var height = 100.0;
  var width = 200.0;
  File _image;
  LocationData locationData;
  String entryDate;
  int wasteCount;

  DocumentReference databaseRef;

  Future<String> saveImage() async{
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(DateTime.now().toIso8601String());
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    final url = await storageReference.getDownloadURL();
    return url;
  }
  void getImage() async{
    final choosenImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(choosenImage.path);
      height = Image.file(_image).height;
      width = Image.file(_image).width;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Save new waste entry'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Center(
                child: Semantics(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2.0, color: const Color(0xFFFFFFFF)))
                    ,
                    child: FlatButton(
                      child: SizedBox(
                        width: width,
                        height: height,
                        child: _image == null
                            ? Center(child: Text('No image selected'))
                            : Image.file(_image),
                      ),
                      onPressed: () => getImage(),
                    )
                  ),
                  label: 'Select image',
                  enabled: true,
                  button: true,
                  onTapHint: 'Select image',
                ),
              ),
            Semantics(
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Waste Count'),
                validator: (String value){
                  if (value.isEmpty){
                    return 'Total waste cannot be left empty';
                  }
                  else if(double.tryParse(value) == null){
                    return 'You must enter a quantity';
                  }
                  else if(double.tryParse(value) < 0){
                    return 'You must enter a positive quantity';
                  }
                  return null;
                  },
                  onSaved: (value){
                    wasteCount = int.parse(value);
                  },
                ),
              label: 'Waste quantity',
              enabled: true,
              textField: true,
              onTapHint: 'Input waste quantity',
            ),
            
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Row(
                children: [
                  Expanded(
                    child: Semantics(
                      child:RaisedButton(
                        child: Text('Cancel'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    label: 'Cancel Entry',
                    enabled: true,
                    button: true,
                    onTapHint: 'Cancel Entry',
                    ),
                  ),
                  Expanded(
                    child: Semantics(
                      child: RaisedButton(
                        child: Text('Submit'),
                        onPressed: () async{
                          if(formKey.currentState.validate()){
                            locationData = await Location().getLocation();
                            entryDate = DateTime.now().toIso8601String();
                            formKey.currentState.save();
                            if(_image != null){
                              saveImage().then((value) {
                                Firestore.instance.collection('posts').add({
                                  'date': entryDate,
                                  'quantity': wasteCount,
                                  'longitude': locationData.longitude,
                                  'latitude': locationData.latitude,
                                  'imageUrl': value
                                });
                              });
                            }
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                      label: 'Submit entry',
                      enabled: true,
                      button: true,
                      onTapHint: 'Save entry',
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
