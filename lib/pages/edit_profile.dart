import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';
import '../validators/validators.dart';
import '../widgets/button_widget.dart';

class EditingProfile extends StatefulWidget {
  const EditingProfile({super.key});

  @override
  State<EditingProfile> createState() => _EditingProfileState();
}



class _EditingProfileState extends State<EditingProfile> {
  final supabase = Supabase.instance.client;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

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
    super.dispose();
  }


  Future<void> _updateUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String firstName = _firstNameController.text;
      String lastName = _lastNameController.text;


      try {
        final UserResponse response = await supabase.auth.updateUser(
          UserAttributes(
            data: {
              'first_name': firstName,
              'last_name': lastName,
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
            child: Container(
              padding: const EdgeInsets.all(35),
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: const Image(
                              image: AssetImage('assets/icons/847969.png'),
                            ),
                          )
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: color,
                            ),
                            child: const Icon(
                              LineAwesomeIcons.camera_solid,
                              size: 20,
                              color: Colors.white,
                            ),
                          )
                      )
                    ],
                  ),
                  const SizedBox(height: 50),
                  Form(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextFormField(
                              controller: _firstNameController,
                              validator: inputValidator,
                              decoration: InputDecoration(
                                label: const Text('First Name'),
                                prefixIcon: const Icon(LineAwesomeIcons.user),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black, width: 0.5),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                contentPadding: const EdgeInsets.only(left: 10),
                                hintText: "Enter you first name",
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),


                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextFormField(
                              controller: _lastNameController,
                              validator: inputValidator,
                              decoration: InputDecoration(
                                label: const Text('Last Name'),
                                prefixIcon: const Icon(LineAwesomeIcons.user),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black, width: 0.5),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                contentPadding: const EdgeInsets.only(left: 10),
                                hintText: "Enter you last name",
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),


                          const SizedBox(height: 60),
                          buttonStyle(_isLoading ? 'Updating...' : 'Update', _isLoading ? null : _updateUser),

                        ],
                      )
                  )
                ],
              ),
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
    }
  }

}







