import 'package:flutter/material.dart';

class Note extends Object {
  int id;
  String date;
  String content;
  String title;
  int isArchived;
  int isImportant;
  int isSelected;
  int color;

  @override
  String toString() {
    return "{"
        "id: ${this.id},"
        "date: ${this.date},"
        "content: ${this.content},"
        "title: ${this.title},"
        "isArchived: ${this.isArchived},"
        "isImportant: ${this.isImportant},"
        "isSelected: ${this.isSelected},"
        "color: ${this.color},"
        "}";
  }

  Note.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = json['date'],
        title = json['title'],
        content = json['content'],
        isArchived = json['isArchived'],
        isImportant = json['isImportant'],
        isSelected = json['isSelected'],
        color = json['color'];

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'title': title,
      'content': content,
      'isArchived': isArchived,
      'isImportant': isImportant,
      'isSelected': isSelected,
      'color': color
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'title': title,
      'content': content,
      'isArchived': isArchived,
      'isImportant': isImportant,
      'isSelected': isSelected,
      'color': color
    };
  }

  Note({
    id,
    @required this.content,
    this.title,
    @required this.isArchived,
    @required this.isImportant,
    isSelected,
    color,
    date,
  })  : date = date ?? DateTime.now().toString(),
        id = id ?? 0,
        isSelected = isSelected ?? 0,
        color = color ?? Colors.white38.value;
}
