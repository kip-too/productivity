import 'package:todo_list_app/features/todos/data/todo/todo_repo_interface.dart';

import '../../../../core/utils/db_helper.dart';

class SqfliteTodoRepository implements TodoRepository {
  final TodoDatabaseHelper _databaseHelper = TodoDatabaseHelper();

  @override
  Future<List<Map<String, dynamic>>> fetchTodos() async {
    return _databaseHelper.fetchTodos();
  }

  @override
  Future<int> insertTodo(Map<String, dynamic> todo) async {
    return _databaseHelper.insertTodo(todo);
  }

  @override
  Future<int> updateTodo(Map<String, dynamic> todo) async {
    return _databaseHelper.updateTodo(todo);
  }

  @override
  Future<int> deleteTodo(int id) async {
    return _databaseHelper.deleteTodo(id);
  }
}
