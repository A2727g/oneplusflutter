// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tickets/utils/constants.dart';
import 'addTicketPage.dart';
import 'utils/temp.dart';
import 'package:http/http.dart' as http;

class TicketPageScreen extends StatefulWidget {
  const TicketPageScreen({Key? key}) : super(key: key);
  @override
  TicketPageScreenState createState() => TicketPageScreenState();
}

List<Datum> addTicketPage = [];

class TicketPageScreenState extends State<TicketPageScreen> {
  File? imageFile;
  bool showImage = false;
  String? itemValue;
  String? billMaterialValue;
  String? causeValue;
  String? categoryValue;
  String? descValue;
  String? file_url;
  final imagePicker = ImagePicker();

  myDropDeco(String hintText) => DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
        hintText: hintText,
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
      ));

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double bodyPadding = 24;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black,
          elevation: 8,
          title: const Text(
            'Add ticket',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
        ),
        body: ListView(children: [
          Padding(
            padding: EdgeInsets.all(bodyPadding),
            child: Column(children: <Widget>[
              //Category
              DropdownSearch<String>(
                dropdownButtonProps: const DropdownButtonProps(
                    icon: Icon(Icons.keyboard_arrow_down, color: Colors.black)),
                dropdownDecoratorProps: myDropDeco('CATEGORY'),
                popupProps: const PopupProps.menu(),
                items:
                    excel.map((e) => e["CATEGORY"] as String).toSet().toList(),
                onChanged: (val) {
                  categoryValue = val ?? categoryValue;
                  setState(() {});
                },
                selectedItem: categoryValue,
              ),
              const SizedBox(
                height: 16,
              ),
              //Items
              DropdownSearch<String>(
                dropdownDecoratorProps: myDropDeco('ITEM'),
                dropdownButtonProps: const DropdownButtonProps(
                    icon: Icon(Icons.keyboard_arrow_down, color: Colors.black)),
                popupProps: const PopupProps.menu(fit: FlexFit.loose),
                onChanged: (val) {
                  itemValue = val ?? itemValue;
                  setState(() {});
                },
                items: excel
                        .where((e) => e['CATEGORY'] == categoryValue)
                        .map((e) {
                          return e["ITEM"] as String;
                        })
                        .toSet()
                        .toList() +
                    ["OTHERS"],
                selectedItem: itemValue,
                validator: (items) {
                  if (items!.isEmpty) {
                    return 'item';
                  } else {
                    return "";
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              //Bill Of Material
              DropdownSearch<String>(
                dropdownDecoratorProps: myDropDeco('BILL OF MATERIAL'),
                dropdownButtonProps: const DropdownButtonProps(
                    icon: Icon(Icons.keyboard_arrow_down, color: Colors.black)),
                popupProps: const PopupProps.menu(fit: FlexFit.loose),
                onChanged: (val) {
                  billMaterialValue = val ?? billMaterialValue;
                  setState(() {});
                },
                items: excel
                        .where((e) => e['ITEM'] == itemValue)
                        .map((e) {
                          return e["BILL OF MATERIAL"] as String;
                        })
                        .toSet()
                        .toList() +
                    ["OTHERS"],
                selectedItem: billMaterialValue,
                validator: (items) {
                  if (items!.isEmpty) {
                    return 'item';
                  } else {
                    return "";
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              //Causes
              DropdownSearch<String>(
                dropdownButtonProps: const DropdownButtonProps(
                    icon: Icon(Icons.keyboard_arrow_down, color: Colors.black)),
                dropdownDecoratorProps: myDropDeco("CAUSES"),
                popupProps: const PopupProps.menu(fit: FlexFit.loose),
                onChanged: (val) {
                  causeValue = val ?? causeValue;
                  setState(() {});
                },
                items: excel
                        .where(
                            (e) => e["BILL OF MATERIAL"] == billMaterialValue)
                        .map((e) {
                          return e["CAUSES"] as String;
                        })
                        .toSet()
                        .toList() +
                    ["OTHERS"],
                selectedItem: causeValue,
                validator: (items) {
                  if (items!.isEmpty) {
                    return 'item';
                  } else {
                    return "";
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              //Description
              Container(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    border: Border.all(width: 0)),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Description',
                    border: InputBorder.none,
                  ),
                  onChanged: (val) {
                    descValue = val;
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              // uploading photo
              Container(
                alignment: Alignment.center,
                width: size.width - 2 * bodyPadding - 2,
                height: size.height / 4.0,
                child: DottedBorder(
                  color: const Color.fromARGB(122, 133, 150, 164),
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(8),
                  strokeWidth: 1,
                  dashPattern: const [10, 8],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (showImage)
                            Expanded(
                              child: Image.file(
                                imageFile!,
                              ),
                            ),
                          if (!showImage)
                            const Icon(
                              Icons.camera_alt_outlined,
                              size: 48,
                              color: Color.fromARGB(255, 241, 67, 54),
                            ),
                          if (!showImage)
                            TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          Colors.grey[200]!),
                                ),
                                child: const Text(
                                  textAlign: TextAlign.center,
                                  "Take a photo or upload",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 241, 67, 54),
                                  ),
                                ),
                                onPressed: () async {
                                  await getImage();
                                }),
                          if (!showImage)
                            const SizedBox(
                              width: 250,
                              child: FittedBox(
                                child: Text(
                                  "file extensions supported, pdf, doc, docx, jpeg, jpg, png",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          Color.fromARGB(255, 133, 150, 164)),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ]),
          ),
        ]),

        /// submit ticket button
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 10.0,
            ),
          ]),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: ElevatedButton(
              onPressed: () async {
                if (imageFile != null) {
                  await uploadFile(imageFile);
                }

                var response = await ticketFormPage();

                var responseBody = jsonDecode(response.body);
                logPrint.w(responseBody, 'qqqqqqqqq');

                Navigator.pop(context);

                if (responseBody['meta']['code'] == 200) {
                  await Future.delayed(const Duration(seconds: 2),
                      () => Navigator.pop(context, true));
                } else {
                  Fluttertoast.showToast(
                    msg: "Entries should not be empty",
                    backgroundColor: Colors.grey[100],
                    textColor: Colors.red[800],
                  );

                  await Future.delayed(const Duration(seconds: 0),
                      () => Navigator.pop(context, responseBody));
                }
              },
              style: ElevatedButton.styleFrom(
                  elevation: 10,
                  minimumSize: const Size(double.maxFinite, 52),
                  backgroundColor: const Color.fromARGB(255, 241, 67, 54),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Save and Next", style: TextStyle(fontSize: 20)),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    (Icons.arrow_forward),
                    size: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    try {
      final image = await imagePicker.pickImage(source: ImageSource.camera);
      setState(() {
        imageFile = File(image!.path);
        showImage = true;
      });
    } catch (e, s) {
      logPrint.w(e, 'get image ticket form page $e $s');
    }
  }

  Future<void> uploadFile(File? imageFile) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    var request = http.MultipartRequest(
        'POST', Uri.parse('https://oneplusapi.acceso.in/file/upload'));
    request.headers.putIfAbsent('Authorization', () => token!);
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile!.path));

    var res = await request.send();
    var streamDecodedValue = await utf8.decodeStream(res.stream);
    var responseBody = jsonDecode(streamDecodedValue);

    if (responseBody['meta']['code'] == 200) {
      if (responseBody['data'].containsKey('file_url')) {
        file_url = responseBody['data']['file_url'];
      } else {
        file_url = '';
      }
    }
  }

  Future<http.Response> ticketFormPage() async {
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final response = await http.post(
      Uri.parse('https://oneplusapi.acceso.in/ticket/inserTicket'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token!,
      },
      body: jsonEncode(<String, dynamic>{
        "category": categoryValue,
        "item": itemValue,
        "bill_of_material": billMaterialValue,
        "causes": causeValue,
        "description": descValue,
        'ticket_image': file_url
      }),
    );

    var temp = jsonDecode(response.body);
    var token3 = temp["token"];
    await prefs.setString('token', token3);
    return response;
  }
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
