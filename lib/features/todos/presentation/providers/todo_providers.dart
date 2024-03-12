import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/todo/todo_repo_impl.dart';
import '../../data/todo/todo_repo_interface.dart';

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  return SqfliteTodoRepository();
});

final todoListProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final repository = ref.watch(todoRepositoryProvider);
  return repository.fetchTodos();
});

final isDarkModeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false);

  void toggleTheme() {
    state = !state;
  }
}