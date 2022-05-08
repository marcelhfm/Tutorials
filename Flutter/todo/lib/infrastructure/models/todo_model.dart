// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/id.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/todo_color.dart';

class TodoModel {
  final String id;
  final String title;
  final String body;
  final bool done;
  final int color;
  final dynamic serverTimeStamp;

  TodoModel(
      {required this.id,
      required this.title,
      required this.body,
      required this.done,
      required this.color,
      required this.serverTimeStamp});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'done': done,
      'color': color,
      'serverTimeStamp': serverTimeStamp,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: "",
      title: map['title'] as String,
      body: map['body'] as String,
      done: map['done'] as bool,
      color: map['color'] as int,
      serverTimeStamp: map['serverTimeStamp'] as dynamic,
    );
  }

  TodoModel copyWith({
    String? id,
    String? title,
    String? body,
    bool? done,
    int? color,
    dynamic? serverTimeStamp,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      done: done ?? this.done,
      color: color ?? this.color,
      serverTimeStamp: serverTimeStamp ?? this.serverTimeStamp,
    );
  }

  factory TodoModel.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return TodoModel.fromMap(doc.data()).copyWith(id: doc.id);
  }

  Todo toDomain() {
    return Todo(
        id: UniqueId.fromUniqueString(id),
        title: title,
        body: body,
        done: done,
        color: TodoColor(color: Color(color).withOpacity(1)));
  }

  factory TodoModel.fromDomain(Todo todoItem) {
    return TodoModel(
        id: todoItem.id.value,
        title: todoItem.title,
        body: todoItem.body,
        done: todoItem.done,
        color: todoItem.color.color.value,
        serverTimeStamp: FieldValue.serverTimestamp());
  }
}
