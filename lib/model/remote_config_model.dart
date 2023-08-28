// To parse this JSON data, do
//
//     final remoteConfigModel = remoteConfigModelFromJson(jsonString);

import 'dart:convert';

List<RemoteConfigModel> remoteConfigModelFromJson(String str) =>
    List<RemoteConfigModel>.from(
        json.decode(str).map((x) => RemoteConfigModel.fromJson(x)));

String remoteConfigModelToJson(List<RemoteConfigModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RemoteConfigModel {
  int userId;
  int id;
  String title;
  String body;

  RemoteConfigModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory RemoteConfigModel.fromJson(Map<String, dynamic> json) =>
      RemoteConfigModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
