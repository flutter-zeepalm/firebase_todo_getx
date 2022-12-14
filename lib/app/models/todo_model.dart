import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TodoModel {
  String id;
  String ownerid;
  String title;
  String description;
  bool isCheck;
  List<String> likes;
  List<String> dislikes;
  TodoModel({
    required this.id,
    required this.ownerid,
    required this.title,
    required this.description,
    required this.isCheck,
    required this.likes,
    required this.dislikes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ownerid': ownerid,
      'title': title,
      'description': description,
      'isCheck': isCheck,
      'likes': likes,
      'dislikes': dislikes,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] as String,
      ownerid: map['ownerid'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      isCheck: map['isCheck'] as bool,
      likes: List<String>.from((map['likes'] as List<dynamic>)),
      dislikes: List<String>.from((map['dislikes'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
