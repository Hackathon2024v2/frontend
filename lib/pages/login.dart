import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/pages/register.dart';
import 'package:iconsax/iconsax.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';
import '../validators/validators.dart';
import '../widgets/button_widget.dart';
import '../widgets/input_widget.dart';

const padding = Padding(
  padding: EdgeInsets.only(bottom: 25),
);

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final supabase = Supabase.instance.client;
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  bool _isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String email = _emailController.text;
      String password = _passwordController.text;

      try {
        final response = await Supabase.instance.client.auth.signInWithPassword(
          email: email,
          password: password,
        );

        if (response.user != null) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(
                  "Login successful! Welcome ${response.user!.email}")),
            );
          }
        }
      } catch (e) {
        final error = e is AuthException ? e.message : "Something went wrong.";
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error)),
          );
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all required fields")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: color,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      body: content(),
    );
  }

  Widget content() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 60 ),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Column(
                children: [
                  Image.asset('assets/icons/cover.png', height: 150, width: 150),
                  Text(
                    'Welcome to Gymbud',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),

                ],
              ),
            ),

            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 35, 0),
                    child: buildTextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "Enter your email address",
                      validator: emailValidator,
                    ),
                  ),

                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 35, 0),
                    child: Column(
                      children: [
                        buildTextField(
                          controller: _passwordController,
                          hintText: "Enter your password",
                          validator: passwordValidator,
                          obscureText: !_passwordVisible,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible ? Iconsax.eye : Iconsax.eye_slash,
                              color: color,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),

                        const SizedBox(height: 5),
                        Container(
                            alignment: Alignment.centerRight,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: 'Forgot password?',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: color,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic, // Italicize the text
                                ),
                                recognizer: TapGestureRecognizer()..onTap = () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => const ForgotPassword()),
                                  // );
                                },
                              ),
                            )
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),
                  buttonStyle(_isLoading ? 'Logging in...' : 'Login', _isLoading ? null : _login),

                  const SizedBox(height: 10),
                  Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: color,
                        width: 1.5,
                      ),
                    ),
                    child: TextButton(
                        onPressed: redirect,
                        child: const Text(
                          'Create account',
                          style: TextStyle(
                            fontSize: 20,
                            color: color,
                          ),
                        )
                    ),
                  ),

                  padding,

                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),  // Add left and right padding
                        child: Divider(
                          color: color,  // Change the divider color to black
                          thickness: 1.5,  // You can adjust the thickness as needed
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Text(
                          'or sign up with',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ],
                  ),


                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: color,
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Image(
                            image: AssetImage('assets/icons/google-icon.png'),
                            height: 30,
                            width: 30,
                          ),
                        )
                      )
                    ]
                  ),

                  padding,
                ],
              )
            )
          ],
        )
      )
    );
  }

  void redirect() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Register()),
    );
  }

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }
}