import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// To parse this JSON data, do
//
//     final payload = payloadFromJson(jsonString);

import 'dart:convert';

Payload payloadFromJson(String str) => Payload.fromJson(json.decode(str));

String payloadToJson(Payload data) => json.encode(data.toJson());


 class Payload {
  List<Datum> data;

  Payload({
    this.data,
  });

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  DateTime date;
  List<Detail> details;

  Datum({
    this.date,
    this.details,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    date: DateTime.parse(json["Date"]),
    details:
    List<Detail>.from(json["Details"].map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Date":
    "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "Details": List<dynamic>.from(details.map((x) => x.toJson())),
  };
}

class Detail {
  int id;

  Detail({
    this.id,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}


class dropdown extends StatefulWidget {
  @override
  _dropdownState createState() => _dropdownState();
}

class _dropdownState extends State<dropdown> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
