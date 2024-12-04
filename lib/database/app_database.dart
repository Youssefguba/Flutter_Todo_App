import 'todo_table.dart';

import 'package:drift/drift.dart';
import 'connection/connection.dart' as c;


// This part directive tells Dart to include the generated code.
part 'app_database.g.dart';

@DriftDatabase(tables: [Todos])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(c.connect());

  @override
  int get schemaVersion => 1;

  // Create
  Future<int> insertTodoEntry(TodosCompanion entry) {
    return into(todos).insert(entry);
  }

  // Read
  Future<List<Todo>> getAllTodos() => select(todos).get();
  Stream<List<Todo>> watchAllTodos() => select(todos).watch();

  // Update
  Future<bool> updateTodoEntry(Todo entry) {
    return update(todos).replace(entry);
  }

  // Delete
  Future<int> deleteTodoEntry(Todo entry) {
    return delete(todos).delete(entry);
  }
}
