// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tickets/login_page.dart';
import 'package:tickets/ticket_list_page.dart';
import 'package:tickets/utils/app_color_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  String finalPhone = '';

  @override
  initState() {
    super.initState();
    lightCustomBar();
    getValidationData();
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedPhone = sharedPreferences.getString("_phone");
    finalPhone = obtainedPhone ?? "";
    Future.delayed(
        const Duration(milliseconds: 500),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (c) => finalPhone.isEmpty
                    ? const LoginPage()
                    : const TicketListPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset(
        'assets/image/OnePlus_logo.png',
        width: 200,
        height: 100,
      )),
    );
  }
}
