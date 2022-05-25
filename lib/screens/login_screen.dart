import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_flutter/screens/signup_screen.dart';
import 'package:instagram_flutter/widgets/text_field_input.dart';

import '../resources/auth_methods.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      showSnackbar(res, context);
    }
  }

  void navigateToSignup() async {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignupScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              SvgPicture.asset(
                'assets/images/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 64),
              //Text Field for Email
              TextFieldInput(
                  textEditingController: _emailController,
                  textInputType: TextInputType.emailAddress,
                  hintText: "Enter your Email"),

              const SizedBox(height: 24),

              //Text Field for Password
              TextFieldInput(
                textEditingController: _passwordController,
                textInputType: TextInputType.text,
                hintText: "Enter your Password",
                isPass: true,
              ),
              const SizedBox(height: 12),

              InkWell(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: _isLoading
                        ? const CircularProgressIndicator(color: primaryColor)
                        : const Text('Login'),
                    onPressed: loginUser,
                    style: ElevatedButton.styleFrom(
                      primary: blueColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: navigateToSignup,
                    child: Container(
                      child: const Text("Don't have an account?"),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                  Container(
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
