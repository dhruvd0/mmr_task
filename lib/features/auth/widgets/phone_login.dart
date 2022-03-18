import 'package:flutter/material.dart';
import 'package:mmr_task/config/theme/theme.dart';

import 'package:mmr_task/features/auth/widgets/phone_input_page.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({Key? key}) : super(key: key);

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  final PageController controller = PageController();
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColors.lightGrey,
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const PhoneNumberPage(),
        ),
      ),
    );
  }
}
