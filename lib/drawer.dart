// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tickets/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  final Map<String, dynamic> userInfoData;

  const MyDrawer({required this.userInfoData, Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String userFirstName = "";
  String userLastName = "";
  String userNameInitials = "";
  String userRole = "";

  @override
  void initState() {
    if (widget.userInfoData.containsKey('user')) {
      userFirstName =
          isStringValid(text: widget.userInfoData['user']['userFirstName'])
              ? widget.userInfoData['user']['userFirstName']
              : "";

      userLastName =
          isStringValid(text: widget.userInfoData['user']['userLastName'])
              ? widget.userInfoData['user']['userLastName']
              : "";

      userNameInitials = isStringValid(text: userFirstName)
          ? userFirstName.toString().substring(0, 1)
          : "";

      userRole = widget.userInfoData['user']['userRole'].toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var drawerEntryTextStyle =
        const TextStyle(fontSize: 18, fontWeight: FontWeight.w400);

    return SafeArea(
      child: Drawer(
        width: 0.8 * size.width,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(224, 229, 232, 1),
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(80),
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.orange,
                          child: Center(
                            child: Text(
                              userNameInitials,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 24,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$userFirstName $userLastName",
                        style: const TextStyle(
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(131, 145, 161, 1),
                            fontSize: 18),
                      ),
                      Text(
                        userRole,
                        style: const TextStyle(
                            fontFamily: 'Urbanist Font Family',
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(131, 145, 161, 1),
                            fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(
                  'Help and Support',
                  style: drawerEntryTextStyle,
                ),
              ),
              leading: const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Icon(Icons.question_mark_rounded),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                'Rate the App',
                style: drawerEntryTextStyle,
              ),
              leading: const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Icon(
                  Icons.star,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                'Feedback',
                style: drawerEntryTextStyle,
              ),
              leading: const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Icon(
                  Icons.people,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                'Share the App ',
                style: drawerEntryTextStyle,
              ),
              leading: const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Icon(
                  Icons.person_add_alt_1,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                'Logout',
                style: drawerEntryTextStyle,
              ),
              leading: const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Icon(
                  Icons.logout_rounded,
                ),
              ),
              onTap: () async {
                final SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.remove('_phone');
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (c) => const LoginPage()));
              },
            ),
            const SizedBox(
              height: 200,
            ),
          ],
        ),
      ),
    );
  }

  bool isStringValid({String? text}) {
    if (text != null && text != '') {
      return true;
    }
    return false;
  }
}
