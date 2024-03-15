import 'package:flutter/material.dart';
import 'package:todo_list_app/core/utils/auth_functions.dart';
import '../../../../core/theme/app_pallete.dart';
import '../widgets/auth_field.dart';
import '../widgets/auth_gradient_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                "Sign Up",
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
                      isObscureText: true,
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
                      buttonText: "Sign Up",
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          dynamic userValue = await createUser(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          setState(() {
                            isLoading = false;
                          });
                          if (userValue != null) {
                            Navigator.pushNamed(context, '/');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    const Text("Invalid email or password!"),
                              ),
                            );
                          }
                        }
                      },
                    ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text(
                      "Login",
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
