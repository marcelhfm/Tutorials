import 'package:todo/domain/entities/todo.dart';

abstract class TodoFailure {}

class InsufficientPermissions extends TodoFailure {}

class UnexpectedFailure extends TodoFailure {}
