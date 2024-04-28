import 'package:dala_flutter/dala/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final bool enable;
  final VoidCallback onPressed;

  const LoginButton({super.key, required this.title, this.enable = true,  required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        height: 45,
        onPressed: enable ? onPressed : null,
        disabledColor: Colors.grey,
        color: Colors.blue,
        child: Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }
}
