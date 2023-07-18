// // To parse this JSON data, do
// //
// //     final ticketListPageResponse = ticketListPageResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// TicketListPageResponse ticketListPageResponseFromJson(str) => TicketListPageResponse.fromJson((str));
//
// String ticketListPageResponseToJson(TicketListPageResponse data) => json.encode(data.toJson());
//
// class TicketListPageResponse {
//   TicketListPageResponse({
//     required this.meta,
//     required this.data,
//     required this.token,
//   });
//
//   Meta meta;
//   List<Datum> data;
//   String token;
//
//   factory TicketListPageResponse.fromJson(Map<String, dynamic> json) => TicketListPageResponse(
//     meta: Meta.fromJson(json["meta"]??{}),
//     data: json['meta']?['code']==200?(json["data"].map((x) => Datum.fromJson(x))).toList():[],
//     token: json["token"]??'',
//   );
//
//   Map<String, dynamic> toJson() => {
//     "meta": meta.toJson(),
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     "token": token,
//   };
// }
//
// class Datum {
//   Datum({
//     required this.userTicketId,
//     required this.userTicketCategory,
//     required this.userTicketItem,
//     required this.userTicketBillOfMaterial,
//     required this.userTicketCause,
//     required this.userTicketDescription,
//     this.userTicketImageUrl,
//     required this.status,
//     required this.createdBy,
//     this.updatedBy,
//     required this.createdAt,
//     this.updatedAt,
//   });
//
//   int userTicketId;
//   String userTicketCategory;
//   String userTicketItem;
//   String userTicketBillOfMaterial;
//   String userTicketCause;
//   String userTicketDescription;
//   dynamic userTicketImageUrl;
//   String status;
//   int createdBy;
//   dynamic updatedBy;
//   DateTime createdAt;
//   dynamic updatedAt;
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     userTicketId: json["user_ticket_id"],
//     userTicketCategory: json["user_ticket_category"]??'',
//     userTicketItem: json["user_ticket_item"]??'',
//     userTicketBillOfMaterial: json["user_ticket_bill_of_material"]??'',
//     userTicketCause: json["user_ticket_cause"]??'',
//     userTicketDescription: json["user_ticket_description"]??'',
//     userTicketImageUrl: json["user_ticket_image_url"],
//     status: json["status"],
//     createdBy: json["created_by"]??0,
//     updatedBy: json["updated_by"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "user_ticket_id": userTicketId,
//     "user_ticket_category": userTicketCategory,
//     "user_ticket_item": userTicketItem,
//     "user_ticket_bill_of_material": userTicketBillOfMaterial,
//     "user_ticket_cause": userTicketCause,
//     "user_ticket_description": userTicketDescription,
//     "user_ticket_image_url": userTicketImageUrl,
//     "status": status,
//     "created_by": createdBy,
//     "updated_by": updatedBy,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt,
//   };
// }
//
// class Meta {
//   Meta({
//     required this.status,
//     required this.message,
//     required this.code,
//   });
//
//   bool status;
//   String message;
//   int code;
//
//   factory Meta.fromJson(Map<String, dynamic> json) => Meta(
//     status: json["status"],
//     message: json["message"],
//     code: json["code"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "code": code,
//   };
// }
//
//
//
//
//

// To parse this JSON data, do
//
//     final ticketListPageResponse = ticketListPageResponseFromJson(jsonString);

import 'dart:convert';

TicketListPageResponse ticketListPageResponseFromJson(str) => TicketListPageResponse.fromJson((str));

String ticketListPageResponseToJson(TicketListPageResponse data) => json.encode(data.toJson());

class TicketListPageResponse {
  TicketListPageResponse({
    required this.meta,
    required this.data,
    required this.token,
  });

  Meta meta;
  List<Datum> data;
  String token;

  factory TicketListPageResponse.fromJson(Map<String, dynamic> json) => TicketListPageResponse(
    meta: Meta.fromJson(json["meta"]),
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "meta": meta.toJson(),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "token": token,
  };
}

class Datum {
  Datum({
    required this.userTicketId,
    required this.userTicketCategory,
    required this.userTicketItem,
    required this.userTicketBillOfMaterial,
    required this.userTicketCause,
    required this.userTicketDescription,
    this.userTicketImageUrl,
    required this.status,
    required this.createdBy,
    this.updatedBy,
    required this.createdAt,
    this.updatedAt,
  });

  int userTicketId;
  String userTicketCategory;
  String userTicketItem;
  String userTicketBillOfMaterial;
  String userTicketCause;
  String userTicketDescription;
  dynamic userTicketImageUrl;
  String status;
  int createdBy;
  dynamic updatedBy;
  DateTime createdAt;
  dynamic updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    userTicketId: json["user_ticket_id"],
    userTicketCategory: json["user_ticket_category"]??'',
    userTicketItem: json["user_ticket_item"]??'',
    userTicketBillOfMaterial: json["user_ticket_bill_of_material"]??'',
    userTicketCause: json["user_ticket_cause"]??'',
    userTicketDescription: json["user_ticket_description"]??'',
    userTicketImageUrl: json["user_ticket_image_url"],
    status: json["status"],
    createdBy: json["created_by"]??0,
    updatedBy: json["updated_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "user_ticket_id": userTicketId,
    "user_ticket_category": userTicketCategory,
    "user_ticket_item": userTicketItem,
    "user_ticket_bill_of_material": userTicketBillOfMaterial,
    "user_ticket_cause": userTicketCause,
    "user_ticket_description": userTicketDescription,
    "user_ticket_image_url": userTicketImageUrl,
    "status": status,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt,
  };
}

class Meta {
  Meta({
    required this.status,
    required this.message,
    required this.code,
  });

  bool status;
  String message;
  int code;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    status: json["status"],
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
  };
}
