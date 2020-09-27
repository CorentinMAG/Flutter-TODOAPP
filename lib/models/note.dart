import 'package:flutter/material.dart';

class Note extends Object {
  static int i = 0;

  final int id = Note._increment();
  DateTime date;
  String content;
  String title;
  bool isArchived;
  bool isImportant;
  Color color;

  @override
  String toString() {
    return "{id: ${this.id}, date: ${this.date}, content: ${this.content}, title: ${this.title}, isArchived: ${this.isArchived}, isImportant: ${this.isImportant}, color: ${this.color}";
  }

  Note({
    @required this.content,
    this.title,
    @required this.isArchived,
    @required this.isImportant,
    color,
    date,
  })  : date = date ?? DateTime.now(),
        color = color ?? Colors.white38;

  static int _increment() {
    return i++;
  }
}
