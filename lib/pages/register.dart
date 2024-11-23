import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';
import '../validators/validators.dart';
import '../widgets/button_widget.dart';
import '../widgets/input_widget.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final supabase = Supabase.instance.client;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: const Text(
          'REGISTER',
          style: TextStyle(
            color: Colors.white, // Red color
            fontStyle: FontStyle.italic, // Italic style
            fontSize: 24, // Optional: Adjust size
          ),
        ),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(LineAwesomeIcons.arrow_left_solid),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
      ),
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


            const Padding(
              padding: EdgeInsets.only(bottom: 25),
            ),

            const SizedBox(height: 15),
            Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 35, 0),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Personal information',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.black, // Set the text color to black
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),

                    buildTextField(
                      labelText: 'First name',
                      controller: _firstNameController,
                      hintText: "Enter your first name",
                      validator: inputValidator,
                    ),
                  ],
                )
            ),

            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 35, 0),
              child: buildTextField(
                labelText: 'Last name',
                controller: _lastNameController,
                hintText: "Enter your last name",
                validator: inputValidator,
              ),
            ),

            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 35, 0),
              child: buildTextField(
                labelText: 'Height (cm)',
                controller: _heightController,
                hintText: "Enter your height (cm)",
                validator: validateHeight,
                keyboardType: TextInputType.number
              ),
            ),

            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 35, 0),
              child: buildTextField(
                  labelText: 'Weight (kg)',
                  controller: _weightController,
                  hintText: "Enter your weight (kg)",
                  validator: validateWeight,
                  keyboardType: TextInputType.number
              ),
            ),

            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 35, 0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'account configuration',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black, // Set the text color to black
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  buildTextField(
                    labelText: 'Email address',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Enter your email address",
                    validator: emailValidator,
                  ),
                ],
              )
            ),


            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 35, 0),
              child: buildTextField(
                labelText: 'Password',
                controller: _passwordController,
                hintText: "Enter your password",
                validator: passwordValidator,
                obscureText: true,
              ),
            ),


            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 35, 0),
              child: buildTextField(
                labelText: 'Password confirmation',
                controller: _confirmController,
                hintText: "Confirm your password",
                validator: (value) => passwordConfirmationValidator(value, _passwordController.text),
                obscureText: true,
              ),
            ),

            const SizedBox(height: 15),
            Text(
              'Choose an avatar',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.black, // Set the text color to black
                decoration: TextDecoration.underline,
              ),
            ),

            const SizedBox(height: 60),
            Container(
              alignment: FractionalOffset.bottomCenter,
              child: buttonStyle(
                _isLoading ? 'Registering...' : 'Register',
                _isLoading ? null : _register
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(bottom: 60),
            ),
          ],
        )
      )
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }


  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String email = _emailController.text;
      String password = _passwordController.text;
      String firstName = _firstNameController.text;
      String lastName = _lastNameController.text;

      try {
        final response = await supabase.auth.signUp(
          email: email,
          password: password,
          data: {
            'first_name': firstName,
            'last_name': lastName,
          },
        );

        if (response.user != null) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Registration successful! Welcome, ${response.user!.email}"),
              ),
            );
          }
          // Navigate to another screen or clear form
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

}