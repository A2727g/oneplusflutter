import 'package:flutter/material.dart';

import 'utils/constants.dart';

class TicketCard {
  const TicketCard(
      {this.ticketName,
      this.ticketCategory,
      this.status1,
      this.status2,
      this.dateTime});
  final String? ticketName;
  final String? ticketCategory;
  final String? status1;
  final String? status2;
  final String? dateTime;
  static const Map<String, Color> statusColorMap = {
    'open': ColorConstants.openStatus,
    'close': ColorConstants.closeStatus,
    'pending': ColorConstants.pendingStatus,
    'in process': ColorConstants.inProcessStatus,
  };
  static const Map<String, Color> ticketColorMap = {
    'e': ColorConstants.eTicketName,
    'a': ColorConstants.aTicketName,
    'w': ColorConstants.wTicketName,
    'c': ColorConstants.cTicketName,
  };
  static const Map<String, Color> status2ColorMap = {
    'expedite': ColorConstants.expediteStatus2,
  };
  static const Map<String, Color> statusTextColorMap = {
    'expedite': ColorConstants.expediteStatusText,
  };
  static const Map<String, Color> status1ColorMap = {
    'open': ColorConstants.openStatus1,
    'close': ColorConstants.closeStatus1,
    'pending': ColorConstants.pendingStatus1,
    'in process': ColorConstants.inProcessStatus1,
  };
  factory TicketCard.fromMap(Map<String, dynamic> json) {
    return TicketCard(
      ticketName: json['ticketName'],
      ticketCategory: json['ticketCategory'],
      status1: json['status1'],
      status2: json['status2'],
      dateTime: json['dateTime'],
    );
  }
}

/// .../getTicketList
Map reqBodyTicketList = {};

Map resBodyTicketList = {};

/// .../getTicketData
Map reqBodyTicketData = {"id": 4};

Map resBodyTicketData = {
  "meta": {
    "status": true,
    "message": "Otp verification failed, Enter valid otp!",
    "code": 409
  },
  "data": {
    "ticketCategory": "Wall Paintings",
    "ticketName": "Name1",
    "status1": "InProcess",
    "status2": "Expedite",
    "dateTime": "2022-11-18T13:04:00.000Z",
    "imageUrl": "image.com",
    "causes": "Damage",
    "items": "Air Conditioning",
    "billOfMaterial": "E-Way Bill",
    "rectificationOfMeasures": "Replace",
    "description": "This is my description"
  },
  "token":
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjp7InVzZXJJZCI6MSwiY2xpZW50SWQiOjIsInVzZXJOYW1lIjoiU2h1YmhhbSIsInVzZXJFbWFpbCI6InNodWJoYW1AbW9vbGNvZGUuY29tIiwidXNlck51bWJlciI6IjgyNjI5ODAwMDAiLCJ1c2VyUm9sZSI6IkFkbWluIiwidXNlclN0YXR1cyI6IkFjdGl2ZSIsImRldmljZVR5cGUiOm51bGwsImRldmljZVZlcnNpb24iOm51bGx9LCJpYXQiOjE2Njg3ODg2MjB9.2dcw_V4Iwcx9N8ocCFxHAchykKnfyNM1IbNNnFCNso8"
};

/// .../addEditTicket
Map reqBodyEditTicket = {
  "id": 5,
  // "ticketCategory": "Wall Paintings",
  // "ticketName": "Name1",
  // "status1": "InProcess",
  // "status2": "Expedite",
  "imageUrl": "image.com",
  "causes": "Damage",
  "items": "Air Conditioning",
  "billOfMaterial": "E-Way Bill",
  "rectificationOfMeasures": "Replace",
  "description": "This is my description"
};

Map resBodyEditTicket = {
  "meta": {"status": true, "message": "Updated Successfully", "code": 200},
  "data": {},
  "token":
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjp7InVzZXJJZCI6MSwiY2xpZW50SWQiOjIsInVzZXJOYW1lIjoiU2h1YmhhbSIsInVzZXJFbWFpbCI6InNodWJoYW1AbW9vbGNvZGUuY29tIiwidXNlck51bWJlciI6IjgyNjI5ODAwMDAiLCJ1c2VyUm9sZSI6IkFkbWluIiwidXNlclN0YXR1cyI6IkFjdGl2ZSIsImRldmljZVR5cGUiOm51bGwsImRldmljZVZlcnNpb24iOm51bGx9LCJpYXQiOjE2Njg3ODg2MjB9.2dcw_V4Iwcx9N8ocCFxHAchykKnfyNM1IbNNnFCNso8"
};

///.../addOtpLogin
Map reqOtpLogin = {
  "mobile": "999999999",
};

Map resOtpLogin = {
  "meta": {"status": true, "message": "Otp Sent Successfully", "code": 200},
  "data": {
    "otp": "4444",
    "mobile": "9999999999",
  },
  "token":
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjp7InVzZXJJZCI6MSwiY2xpZW50SWQiOjIsInVzZXJOYW1lIjoiU2h1YmhhbSIsInVzZXJFbWFpbCI6InNodWJoYW1AbW9vbGNvZGUuY29tIiwidXNlck51bWJlciI6IjgyNjI5ODAwMDAiLCJ1c2VyUm9sZSI6IkFkbWluIiwidXNlclN0YXR1cyI6IkFjdGl2ZSIsImRldmljZVR5cGUiOm51bGwsImRldmljZVZlcnNpb24iOm51bGx9LCJpYXQiOjE2Njg3ODg2MjB9.2dcw_V4Iwcx9N8ocCFxHAchykKnfyNM1IbNNnFCNso8"
};
