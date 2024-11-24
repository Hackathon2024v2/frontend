import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';
import '../validators/validators.dart';
import '../widgets/button_widget.dart';
import '../widgets/input_widget.dart';

class EditingProfile extends StatefulWidget {
  const EditingProfile({super.key});

  @override
  State<EditingProfile> createState() => _EditingProfileState();
}

final List<int> years = List<int>.generate(
  DateTime.now().year - 1900 - 18 + 1, // From (currentYear - 18) to 1900
      (index) => DateTime.now().year - 18 - index,
);



class _EditingProfileState extends State<EditingProfile> {
  final supabase = Supabase.instance.client;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  int? _selectedYear;

  Future onRefresh() async {
    try {
      // You can fetch the latest user data from Supabase
      final user = supabase.auth.currentUser;

      if (user != null && user.userMetadata != null) {
        // Update the text controllers with the latest data
        _firstNameController.text = user.userMetadata?['first_name'] ?? '';
        _lastNameController.text = user.userMetadata?['last_name'] ?? '';
      }

      // If needed, you can add logic to reload additional data
      setState(() {});
    } catch (e) {
      // Handle errors here if needed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to refresh user data")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: const Text(
          'Edit profile',
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
      body: RefreshIndicator(
          onRefresh: onRefresh,
          child: content()
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _ageController.dispose();
    super.dispose();
  }


  Future<void> _updateUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String firstName = _firstNameController.text;
      String lastName = _lastNameController.text;
      String age = _ageController.text;
      String height = _heightController.text;
      String weight = _weightController.text;

      try {
        final UserResponse response = await supabase.auth.updateUser(
          UserAttributes(
            data: {
              'first_name': firstName,
              'last_name': lastName,
              'height': double.parse(height),
              'weight': double.parse(weight),
              'year': int.parse(age),
            },
          ),
        );

        if (response.user != null) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Informations successfully updated")),
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

  Widget content() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 15),

            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: buildTextField(
                labelText: 'First name',
                controller: _firstNameController,
                hintText: "Enter your first name",
                validator: inputValidator,
              ),
            ),

            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: buildTextField(
                labelText: 'Last name',
                controller: _lastNameController,
                hintText: "Enter your last name",
                validator: inputValidator,
              ),
            ),

            const SizedBox(height: 15),
            Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
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
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
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
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: buildTextField(
                  labelText: 'Weight (kg)',
                  controller: _weightController,
                  hintText: "Enter your weight (kg)",
                  validator: validateWeight,
                  keyboardType: TextInputType.number
              ),
            ),

            const SizedBox(height: 60),
            buttonStyle(_isLoading ? 'Updating...' : 'Update', _isLoading ? null : _updateUser),

          ],
        )
      )
    );
  }

  @override
  void initState() {
    super.initState();
    final user = supabase.auth.currentUser;
    if (user != null && user.userMetadata != null) {
      _firstNameController.text = user.userMetadata?['first_name'] ?? '';
      _lastNameController.text = user.userMetadata?['last_name'] ?? '';
      _selectedYear = DateTime.now().year - int.parse(user.userMetadata?['age']?? '0');
      _ageController.text = _selectedYear?.toString()?? '';
      _heightController.text = user.userMetadata?['height']?? '';
      _weightController.text = user.userMetadata?['weight']?? '';
    }
  }

}







