import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_list_app/core/constants/supabase_keys.dart';
import 'package:flutter/services.dart';

Future<String?> userLogin({
  required String email,
  required String password,
  required BuildContext context,
}) async {
  try {
    final response = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final user = response.user?.id.toString();
    return user;
  } on PlatformException catch (error) {
    Fluttertoast.showToast(
        msg: '${error.message}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.white,
        textColor: Colors.red,
        fontSize: 16.0
    );
    return null;
  } catch (error) {
    Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    return null;
  }
}
Future<String?> createUser({
  required String email,
  required String password,
}) async {
  try {
    final response = await client.auth.signUp(
      email: email,
      password: password,
    );
    final user = response.user?.id.toString();
    return user;
  } on PlatformException catch (error) {
    Fluttertoast.showToast(
      msg: '${error.message}',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.white,
      textColor: Colors.red,
      fontSize: 16.0,
    );
    return null;
  } catch (error) {
    Fluttertoast.showToast(
      msg: error.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    return null;
  }
}


