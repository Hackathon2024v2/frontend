import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/login.dart';
import 'package:flutter_application_2/widgets/avatar_card_widget.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';
import '../validators/validators.dart';
import '../widgets/button_widget.dart';
import '../widgets/input_widget.dart';

final listAvatars = [
  'assets/animals/bear.gif',
  'assets/animals/cat.gif',
  'assets/animals/lion.gif',
  'assets/animals/monkey.gif',
  'assets/animals/whale.gif',
  'assets/animals/wolf.webp',
];

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final supabase = Supabase.instance.client;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String chosenPath = "";
  bool isTapped = false;

  final List<int> years = List<int>.generate(
    DateTime.now().year - 1900 - 18 + 1, // From (currentYear - 18) to 1900
        (index) => DateTime.now().year - 18 - index,
  );

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  int? _selectedYear;

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
          onPressed: () {
            Navigator.pop(context);

          },
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
                child: DropdownButtonFormField<int>(
                  hint: const Text('Select Year'),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    contentPadding: const EdgeInsets.only(left: 10),
                  ),

                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.withOpacity(0.7),
                  ),

                  value: _selectedYear,
                  items: years.map((year) {
                    return DropdownMenuItem<int>(
                      value: year,
                      child: Text(year.toString()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _ageController.text = value?.toString() ?? '';
                    });
                  },
                )
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

            const SizedBox(height: 50),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Enable horizontal scrolling
              child: Row(
                children: List.generate(
                  listAvatars.length, // Number of buttons
                      (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8), // Spacing between buttons
                    child: CardButton(
                      imagePath: listAvatars[index],
                      chosenImagePath: chosenPath,
                      onImagePathChanged: updateChosenImagePath,
                    ),
                  ),
                ),
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

  void updateChosenImagePath(String newPath) {
    setState(() {
      isTapped = !isTapped;
      chosenPath = newPath; // Update the chosen image path
    });
  }


  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _ageController.dispose();
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
      String age = _ageController.text;

      try {
        final registerResponse = await supabase.auth.signUp(
          email: email,
          password: password,
          data: {
            'first_name': firstName[0].toUpperCase() + firstName.substring(1),
            'last_name': lastName[0].toUpperCase() + lastName.substring(1),
            'height': double.parse(_heightController.text),
            'weight': double.parse(_weightController.text),
            'year': int.parse(age),
            'avatar': chosenPath.split('/')[2].split('.')[0],
          },
        );


        if (registerResponse.user != null) {
          await supabase.from('users').insert({
            "first_name": firstName[0].toUpperCase() + firstName.substring(1),
            "last_name": lastName[0].toUpperCase() + lastName.substring(1),
            "height": double.parse(_heightController.text),
            "weight": double.parse(_weightController.text),
            "avatar": chosenPath.split('/')[2].split('.')[0],
          });
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Registration successful! Welcome, ${registerResponse.user!.userMetadata?['first_name']}"),

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
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));

      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all required fields")),
      );
    }
  }


  Widget _buildDropdownField() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: DropdownButtonFormField<int>(
        hint: const Text('Select Year'),
        value: _selectedYear, // This must match exactly one DropdownMenuItem's value or be null.
        items: years.map((year) {
          return DropdownMenuItem<int>(
            value: year,
            child: Text(year.toString()),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedYear = value;
          });
        },
        validator: (value) => value == null ? 'Please select a year' : null,
      ),
    );
  }


  List<int> generateYearList() {
    final currentYear = DateTime.now().year;
    final startYear = currentYear - 18; // Youngest valid year
    const endYear = 1900; // Oldest valid year
    return List<int>.generate(
      startYear - endYear + 1,
          (index) => startYear - index,
    );
  }

}