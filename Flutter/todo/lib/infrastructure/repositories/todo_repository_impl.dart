import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/domain/entities/todo.dart';
import 'package:todo/infrastructure/extensions/firebase_helpers.dart';

import 'package:todo/core/failures/todo_failures.dart';

import 'package:dartz/dartz.dart';
import 'package:todo/infrastructure/models/todo_model.dart';

import '../../domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final FirebaseFirestore firestore;
  TodoRepositoryImpl({required this.firestore});

  @override
  Stream<Either<TodoFailure, List<Todo>>> watchAll() async* {
    final userDoc = await firestore.userDocument();

    //Right side
    yield* userDoc.todoCollection
        .snapshots()
        .map((snapshot) => right<TodoFailure, List<Todo>>(snapshot.docs
            .map((doc) => TodoModel.fromFirestore(doc).toDomain())
            .toList()))
        //Left side (error)
        .handleError((e) {
      if (e is FirebaseException) {
        if (e.code.contains("permission-denied") ||
            e.code.contains("PERMISSION-DENIED")) {
          return left(InsufficientPermissions());
        } else {
          return left(UnexpectedFailure());
        }
      } else {
        return left(UnexpectedFailure());
      }
    });
  }

  @override
  Future<Either<TodoFailure, Unit>> create(Todo todo) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<TodoFailure, Unit>> delete(Todo todo) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<TodoFailure, Unit>> update(Todo todo) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
