import 'package:flutter/material.dart';
import 'package:tickets/get%20ticket%20response/responseTicket.dart';
import 'package:tickets/ticket_list_page.dart';
import 'splash_screen (3).dart';
import 'package:tickets/utils/app_color_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    lightCustomBar();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        floatingActionButtonTheme: Theme.of(context)
            .floatingActionButtonTheme
            .copyWith(backgroundColor: Colors.redAccent),
        brightness: Brightness.light,
        fontFamily: 'Urbanist',
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              backgroundColor: Colors.white,
              elevation: 0.4,
              centerTitle: false,
              iconTheme: IconThemeData(
                color: Colors.grey[800],
              ),
              titleTextStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            buttonColor: Colors.redAccent),
      ),
      home: TicketListPage()
      // const SplashScreen(),
    );
  }
}
