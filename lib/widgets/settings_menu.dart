import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../main.dart';

class SettingMenuWidget extends StatelessWidget {
  const SettingMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    this.txtColor,
    required this.onPress,
    this.endIcon = true,
  });

  final String title;
  final IconData icon;
  final Color? txtColor;
  final VoidCallback onPress;
  final bool endIcon;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: color.withOpacity(0.1)
          ),
          child: Icon(
            icon,
            color: color,
          )
      ),
      title: Text(
        title,
        style: TextStyle(
          color: txtColor,
          fontSize: 18,
        ),
      ),
      textColor: txtColor,
      trailing: endIcon ? Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey.withOpacity(0.1)
          ),
          child: const Icon(
            size: 18,
            LineAwesomeIcons.angle_right_solid,
            color: Colors.grey,
          )
      ) : null,
      onTap: onPress,
    );
  }
}
