import 'dart:io';

import 'package:GreatPlaces/models/place.dart';

import '../widgets/image_input.dart';
import '../widgets/location_input.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';


class AddPlacesScreen extends StatefulWidget {
  static const String routeName = 'add_name';

  @override
  _AddPlacesScreenState createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends State<AddPlacesScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;
  PlaceLocation _pickedLocation;

  void _selectImage(File pickedImage){
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng){
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void _saveImage(){
    if(_titleController.text.isEmpty || _pickedImage == null || _pickedLocation == null){
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false).addPlace(_titleController.text, _pickedImage, _pickedLocation);
    Navigator.of(context).pop();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: "Title"),
                    controller: _titleController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ImageInput(_selectImage),
                  SizedBox(height: 10,),
                  LocationInput(_selectPlace),
                ],
              ),
            )),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text("Add Place"),
            color: Theme.of(context).accentColor,
            onPressed: _saveImage,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          )
        ],
      ),
    );
  }
}
