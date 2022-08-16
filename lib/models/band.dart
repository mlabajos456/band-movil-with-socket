// To parse this JSON data, do
//
//     final band = bandFromJson(jsonString);

import 'dart:convert';

class Banda {
  Banda({
     this.id,
    required this.name,
    required this.votes,
  });

  String? id ;
  String name;
  int votes;

  factory Banda.fromJson(Map<String, dynamic> json) => Banda(
        id: json["id"],
        name: json["name"],
        votes: json["votes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "votes": votes,
      };

  static List<Banda> listFromJson(List<dynamic> list) =>
      List<Banda>.from(list.map((e) => Banda.fromJson(e)));
}
