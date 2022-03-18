import 'package:flutter/material.dart';
import 'package:mmr_task/features/auth/widgets/phone_login.dart';
import 'package:mmr_task/features/home/widgets/home_page.dart';
import 'package:mmr_task/main.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
   
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      if (firebaseConfig!.auth.currentUser != null) {
        await Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => const HomePage())); 
      } else {
        await Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => const PhoneLogin()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
