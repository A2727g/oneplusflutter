import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tickets/utils/constants.dart';
import 'package:tickets/ticket_list_page.dart';
import 'package:tickets/timer_widget.dart';
import 'package:http/http.dart' as http;

class MyOtpPage extends StatefulWidget {
  const MyOtpPage({Key? key, this.phone}) : super(key: key);
  final String? phone;

  @override
  State<MyOtpPage> createState() => _MyOtpPageState();
}

class _MyOtpPageState extends State<MyOtpPage> {
  String otp = "";
  late Future<Album> futureAlbum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 28,
                  ),
                  const Text(
                    'OTP Verification',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 32,
                        color: Colors.redAccent),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Enter the verification code we just sent on your mobile number',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 20),
                  FittedBox(
                    child: Row(
                      children: <Widget>[
                        Text(
                          'please enter OTP sent to',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                        Text(
                          '  +91 ${widget.phone}',
                          style: const TextStyle(
                              color: Colors.redAccent, fontSize: 16),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.grey,
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Pinput(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    defaultPinTheme: PinTheme(
                        textStyle: (const TextStyle(fontSize: 28)),
                        constraints: const BoxConstraints(
                          minWidth: 64,
                          minHeight: 64,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12))),
                    focusedPinTheme: PinTheme(
                        textStyle: (const TextStyle(fontSize: 28)),
                        constraints: const BoxConstraints(
                          minWidth: 64,
                          minHeight: 64,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(12))),
                    submittedPinTheme: PinTheme(
                        textStyle: (const TextStyle(fontSize: 28)),
                        constraints: const BoxConstraints(
                          minWidth: 64,
                          minHeight: 64,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(12))),
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    onCompleted: (pin) {
                      logPrint.w('verify button pressed');
                      otp = pin;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TimerWidget(
                    onClick: (val) {},
                  ),
                  const SizedBox(
                    height: 144,
                  ),
                  SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        var response = await verifyOtp(otp);
                        var responseBody = jsonDecode(response.body);
                        showDialog(
                            context: context,
                            builder: (context) => const Center(
                                child: CircularProgressIndicator()));
                        await Future.delayed(const Duration(seconds: 2));
                        logPrint.w('verify button pressed');
                        if (responseBody['meta']['code'] == 200) {
                          await Future.delayed(const Duration(seconds: 0),
                              () => Navigator.pop(context));
                          await Future.delayed(const Duration(seconds: 0),
                              () => Navigator.pop(context));

                          await Future.delayed(
                              const Duration(seconds: 0),
                              () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const TicketListPage(),
                                  )));
                        } else {
                          await Future.delayed(const Duration(seconds: 0),
                              () => Navigator.pop(context));
                          Fluttertoast.showToast(
                            msg: "Wrong Otp",
                            backgroundColor: Colors.grey[100],
                            textColor: Colors.red[800],
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: const Text(
                        'Verify OTP',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<http.Response> verifyOtp(String otp) async {
  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('token');
  final response = await http.post(
    Uri.parse('https://oneplusapi.acceso.in/login/verifyOtp'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": token!,
    },
    body: jsonEncode(<String, dynamic>{"otp": otp}),
  );

  logPrint.w(response.body);
  logPrint.w(otp);
  var temp = jsonDecode(response.body);
  var token1 = temp["token"];
  await prefs.setString('token', token1);
  return response;
}

class Album {
  final int mobileNumber;

  const Album({
    required this.mobileNumber,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      mobileNumber: json[''],
    );
  }
}
