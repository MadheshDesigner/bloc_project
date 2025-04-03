class ItemModel {
  final int? id;
  final String title;
  final String description;

  ItemModel({this.id, required this.title, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }
}