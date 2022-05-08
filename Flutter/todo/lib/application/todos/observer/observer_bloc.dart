import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:todo/core/failures/todo_failures.dart';
import 'package:todo/domain/repositories/todo_repository.dart';

import '../../../domain/entities/todo.dart';

part 'observer_event.dart';
part 'observer_state.dart';

class ObserverBloc extends Bloc<ObserverEvent, ObserverState> {
  final TodoRepository todoRepository;
  StreamSubscription<Either<TodoFailure, List<Todo>>>? _todoStreamSubscription;

  ObserverBloc({required this.todoRepository}) : super(ObserverInitial()) {
    on<ObserveAllEvents>((event, emit) async {
      emit(ObserverLoading());

      await _todoStreamSubscription?.cancel();
      _todoStreamSubscription = todoRepository.watchAll().listen(
          (failureOrTodos) =>
              add(TodosUpdatedEvent(failureOrTodos: failureOrTodos)));
    });

    on<TodosUpdatedEvent>((event, emit) async {
      event.failureOrTodos.fold(
        (failures) => emit(ObserverFailure(todoFailure: failures)),
        (todos) => emit(ObserverSuccess(todos: todos)),
      );
    });
  }

  @override
  Future<void> close() async {
    await _todoStreamSubscription?.cancel();
    return super.close();
  }
}
