import 'package:todo_list_app/core/constants/supabase_keys.dart';

Future<String?> userLogin({
  required String email,
  required String password,
}) async {
  final response = await client.auth.signInWithPassword(
    email: email,
    password: password,
  );
  final user = response.user?.id;
  return user;
}

Future<String?> createUser({
  required String email,
  required String password,
}) async {
  final response = await client.auth.signUp(
    email: email,
    password: password,
  );
  final user = response.user?.id;
  return user;
}

