// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tickets/utils/constants.dart';
import 'package:tickets/otp_login.dart';

import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: GestureDetector(
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
                  SizedBox(
                    width: 0.65 * size.width,
                    child: const FittedBox(
                      child: Text(
                        'login to continue',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 36,
                            color: Colors.redAccent),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'please enter your mobile number to get OTP verify account',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(
                    height: 72,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 8),
                    alignment: Alignment.center,
                    height: 56,
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border:
                            Border.all(width: 1, color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8)),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _phone,
                      decoration: const InputDecoration(
                        isDense: true,
                        prefixIcon: Text(
                          "+91",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(241, 67, 54, 1)),
                        ),
                        prefixIconConstraints:
                            BoxConstraints(minWidth: 40, minHeight: 0),
                        border: InputBorder.none,
                        hintText: "mobile no",
                      ),
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      validator: (value) {
                        if (value!.isEmpty || value.length > 9) {
                          return 'Enter Number only';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 144,
                  ),
                  SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_phone.text.length < 9) {
                          Fluttertoast.showToast(
                            msg: "Mobile should be a 10-digit number",
                            backgroundColor: Colors.grey[100],
                            textColor: Colors.red[800],
                          );
                        } else {
                          setState(() {
                            loginWithOtp();
                          });
                          final SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.setString('_phone', _phone.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MyOtpPage(phone: _phone.text),
                              ));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(241, 67, 54, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                      child: const Text(
                        'SEND OTP',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Album> loginWithOtp() async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('https://oneplusapi.acceso.in/login/loginWithOTPAgent'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "token",
      },
      body: jsonEncode(<String, dynamic>{"mobile": "8869921973"}),
    );
    logPrint.w(response.statusCode);
    logPrint.w(response.body);

    var temp = jsonDecode(response.body);
    var token = temp["token"];
    await prefs.setString('token', token);

    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}
