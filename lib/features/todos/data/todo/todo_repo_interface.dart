abstract class TodoRepository {
  Future<List<Map<String, dynamic>>> fetchTodos();
  Future<int> insertTodo(Map<String, dynamic> todo);
  Future<int> updateTodo(Map<String, dynamic> todo);
  Future<int> deleteTodo(int id);
}
