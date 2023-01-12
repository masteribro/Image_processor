
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/home_model.dart';



class HomeController extends ControllerMVC {
  factory HomeController([StateMVC? state]) =>
      _this ??= HomeController._(state);


  HomeController._(StateMVC? state)
      : model = HomeModel(),
        super(state);
  static HomeController? _this;

  final HomeModel model;


  Future <String?> pickImage() async {
    try {
      final imagePicked = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(imagePicked == null) {
        return model.image?.path;
      }
      final imageTemp = File(imagePicked.path);
      setState(() => model.image = imageTemp);
      print(model.image?.path.toString());
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
    return model.image?.path;
  }

  void deleteImage() async {

    final image = model.image;
    if (image != null) {
      image.delete();
      setState(() {
        model.image = null;
      });
    }

  }
  Future<File>? loadedFile() async {

    if (model.image != null) {

      return  model.image!;
    }

return model.image!;
  }

}
