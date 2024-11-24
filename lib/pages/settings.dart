import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/login.dart';
import 'package:flutter_application_2/widgets/settings_menu.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'SETTINGS',
            style: TextStyle(
              color: Colors.white, // Red color
              fontStyle: FontStyle.italic, // Italic style
              fontSize: 24, // Optional: Adjust size
            )
        ),
        elevation: 0,
        backgroundColor: color,
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
      body: content(context),
    );
  }

  Future<void> _logout() async {
    try {
      await supabase.auth.signOut();

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      }
    } catch (e) {
      final error = e is AuthException ? e.message : "Something went wrong.";
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      }
    }
  }

  Widget content(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 15),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft, // Aligns the text to the left
                    child: Text(
                      'Account information',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black, // Set the text color to black
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),

                SettingMenuWidget(
                  icon: LineAwesomeIcons.user_solid,
                  title: 'Update profile',
                  onPress: () {},
                ),
              ],
            ),

            ///MENU
            SettingMenuWidget(
              icon: LineAwesomeIcons.envelope,
              title: 'Change Email',
              onPress: () {},
            ),

            SettingMenuWidget(
              icon: LineAwesomeIcons.lock_solid,
              title: 'Change Password',
              onPress: () {},
            ),

            const SizedBox(height: 15),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft, // Aligns the text to the left
                    child: Text(
                      'Management',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black, // Set the text color to black
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),

                SettingMenuWidget(
                  icon: LineAwesomeIcons.ban_solid,
                  title: 'Blocked',
                  onPress: () {},
                ),
              ],
            ),

            SettingMenuWidget(
              icon: LineAwesomeIcons.bell_solid,
              title: 'Notifications',
              onPress: () {},
            ),

            SettingMenuWidget(
              icon: LineAwesomeIcons.language_solid,
              title: 'Language',
              onPress: () {},
            ),


            SettingMenuWidget(
              icon: LineAwesomeIcons.star,
              title: 'Favorites',
              onPress: () {},
            ),

            const SizedBox(height: 15),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft, // Aligns the text to the left
                    child: Text(
                      'Billing',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black, // Set the text color to black
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),

                SettingMenuWidget(
                  icon: LineAwesomeIcons.wallet_solid,
                  title: 'Payments',
                  onPress: () {},
                ),
              ],
            ),

            SettingMenuWidget(
              icon: LineAwesomeIcons.credit_card_solid,
              title: 'Fundraisers',
              onPress: () {},
            ),


            const SizedBox(height: 15),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft, // Aligns the text to the left
                    child: Text(
                      'Support',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black, // Set the text color to black
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),

                SettingMenuWidget(
                  icon: LineAwesomeIcons.life_ring_solid,
                  title: 'Help',
                  onPress: () {},
                ),
              ],
            ),

            SettingMenuWidget(
              icon: LineAwesomeIcons.info_circle_solid,
              title: 'About',
              onPress: () {},
            ),

            SettingMenuWidget(
              icon: LineAwesomeIcons.shield_alt_solid,
              title: 'Privacy center',
              onPress: () {},
            ),

            const SizedBox(height: 15),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft, // Aligns the text to the left
                    child: Text(
                      'Login',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black, // Set the text color to black
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),

                SettingMenuWidget(
                  icon: LineAwesomeIcons.sign_out_alt_solid,
                  title: 'Logout',
                  txtColor: Colors.red.shade900,
                  onPress: _logout,
                  endIcon: false,
                ),
              ],
            ),

            const SizedBox(height: 15),
          ],
        )
      ),
    );
  }
}


