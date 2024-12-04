import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/app_database.dart';

part 'todo_state.dart';
class TodoCubit extends Cubit<TodoState> {
  final AppDatabase database;

  TodoCubit(this.database) : super(TodoInitial()) {
    // Start listening to the todos immediately.
    fetchTodos();
  }

  void fetchTodos() {
    emit(TodoLoading());

    database.watchAllTodos().listen((todos) {
      emit(TodoLoaded(todos));
    }, onError: (error) {
      emit(TodoError(error.toString()));
    });
  }

  Future<void> addTodoEntry(TodosCompanion entry) async {
    try {
      await database.insertTodoEntry(entry);
    } catch (error) {
      emit(TodoError(error.toString()));
    }
  }

  Future<void> updateTodoEntry(Todo entry) async {
    try {
      await database.updateTodoEntry(entry);
    } catch (error) {
      emit(TodoError(error.toString()));
    }
  }

  Future<void> deleteTodoEntry(Todo entry) async {
    try {
      await database.deleteTodoEntry(entry);
    } catch (error) {
      emit(TodoError(error.toString()));
    }
  }
}
