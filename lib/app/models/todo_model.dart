import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TodoModel {
  String id;
  String ownerid;
  String title;
  String description;
  bool isCheck;
  TodoModel({
    required this.id,
    required this.ownerid,
    required this.title,
    required this.description,
    required this.isCheck,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ownerid': ownerid,
      'title': title,
      'description': description,
      'isCheck': isCheck,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] as String,
      ownerid: map['ownerid'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      isCheck: map['isCheck'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
