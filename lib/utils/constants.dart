import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class MyLogFilter extends LogFilter{
  @override
  bool shouldLog(LogEvent event) {
    return
      true;
  }
}
Logger logPrint = Logger(filter: MyLogFilter());
class ColorConstants {
  static const Color openStatus = Color.fromARGB(255, 190, 243, 255);
  static const Color closeStatus = Color.fromARGB(115, 255, 201, 11);
  static const Color pendingStatus = Color.fromARGB(87, 247, 20, 252);
  static const Color inProcessStatus = Color.fromARGB(87, 0, 136, 157);
  static const Color openStatus1 = Color.fromARGB(255, 46, 145, 225);
  static const Color closeStatus1 = Color.fromARGB(245, 253, 11, 11);
  static const Color pendingStatus1 = Color.fromARGB(255, 45, 5, 77);
  static const Color inProcessStatus1 = Color.fromARGB(255, 101, 159, 7);
  static const Color expediteStatus2 =Color.fromARGB(255, 203, 255, 226);
  static const Color eTicketName = Color.fromARGB(255, 88, 208, 224);
  static const Color wTicketName = Color.fromARGB(215, 173, 75, 43);
  static const Color aTicketName = Color.fromARGB(215, 190, 114, 10);
  static const Color cTicketName = Color.fromARGB(255, 210, 89, 139);
  static const Color expediteStatusText = Color.fromARGB(255, 63, 196, 86);
}