import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/db_helper.dart';

final todoListNotifierProvider =
StateNotifierProvider<TodoListNotifier, List<Map<String, dynamic>>>((ref) {
  return TodoListNotifier();
});
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);




class TodoListNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  TodoListNotifier() : super([]);

  void loadTodos() async {
    final todos = await TodoDatabaseHelper().fetchTodos();
    state = todos;
  }

  Future<void> addTodo(Map<String, dynamic> todo) async {
    await TodoDatabaseHelper().insertTodo(todo);
    loadTodos();
  }

  Future<void> updateTodo(Map<String, dynamic> todo) async {
    await TodoDatabaseHelper().updateTodo(todo);
    loadTodos();
  }

  Future<void> deleteTodo(int id) async {
    await TodoDatabaseHelper().deleteTodo(id);
    loadTodos();
  }
}







