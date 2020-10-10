import 'package:flutter/material.dart';

class Task {
  int id;
  String date;
  String content;
  int isAlarm;
  int isTicked;

  Task({
    id,
    date,
    @required this.content,
    this.isAlarm,
    this.isTicked,
  })  : date = date ?? DateTime.now().toString(),
        id = id ?? 0;

  @override
  String toString() {
    return "{"
        "id: ${this.id},"
        "date: ${this.date},"
        "content: ${this.content},"
        "isAlarm: ${this.isAlarm},"
        "isTicked: ${this.isTicked},"
        "}";
  }

  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = json['date'],
        content = json['content'],
        isAlarm = json['isAlarm'],
        isTicked = json['isTicked'];

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'date': date,
      'isAlarm': isAlarm,
      'isTicked': isTicked
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'content': content,
      'isAlarm': isAlarm,
      'isTicked': isTicked
    };
  }
}
