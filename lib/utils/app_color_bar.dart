import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

lightCustomBar(){
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light
  ));
}

darkBlueCustomBar(){
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      // statusBarColor: ColorConstants.actionButton,
      statusBarIconBrightness: Brightness.light));
}

