import 'dart:convert';

List<ItemListModel> userListModelFromJson(String str) => List<ItemListModel>.from(json.decode(str).map((x) => ItemListModel.fromJson(x)));

String userListModelToJson(List<ItemListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemListModel {
  int userId;
  int id;
  String title;
  String body;

  ItemListModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory ItemListModel.fromJson(Map<String, dynamic> json) => ItemListModel(
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
