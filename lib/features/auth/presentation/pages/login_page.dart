import 'package:flutter/material.dart';
import 'package:todo_list_app/core/utils/auth_functions.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/theme/app_pallete.dart';
import '../widgets/auth_field.dart';
import '../widgets/auth_gradient_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Login",
                style: TextStyle(
                  fontFamily: 'Kalam',
                  color: AppPallete.whiteColor,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    AuthField(
                      hintText: 'Email',
                      controller: emailController,
                      isEmailField:
                          true, // Set this to true for email validation
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthField(
                      hintText: "Password",
                      controller: passwordController,
                      isPasswordField:
                          true, // Set this to true for password validation
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              isLoading
                  ? Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : AuthGradientButton(
                      buttonText: "Login",
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          dynamic loginValue = await userLogin(
                            email: emailController.text,
                            password: passwordController.text,
                            context: context
                          );
                          setState(() {
                            isLoading = false;
                          });
                          if (loginValue != null) {
                            Navigator.pushNamed(context, '/');
                          } else {
                            Fluttertoast.showToast(
                                msg: "Invalid email or password",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 3,
                                backgroundColor: Colors.white,
                                textColor: Colors.red,
                                fontSize: 16.0
                            );
                          }
                        }
                      },
                    ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
