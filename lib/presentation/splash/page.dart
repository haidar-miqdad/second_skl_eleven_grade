import 'package:flutter/material.dart';
import 'package:flutter_second_skl_eleven_grade/core/assets/assets.gen.dart';
import 'package:flutter_second_skl_eleven_grade/core/constants/colors.dart';
import 'package:flutter_second_skl_eleven_grade/presentation/auth/pages/login_page.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              Assets.lottie.apple,
              width: 200,
              height: 200,
            ),
          ),
        ],
      ),
    );
  }
}
