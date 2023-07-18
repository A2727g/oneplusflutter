import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tickets/drawer.dart';
import 'package:tickets/model/filter_params_model.dart';
import 'package:tickets/filter_widget.dart';
import 'package:tickets/get%20ticket%20response/responseTicket.dart';
import 'package:tickets/model/get_user_filter.dart';
import 'package:tickets/utils/constants.dart';
import 'package:tickets/widgets/ticket_card.dart';
import 'package:tickets/ticket_form_page.dart';
import 'package:http/http.dart' as http;

class TicketListPage extends StatefulWidget {
  const TicketListPage({Key? key}) : super(key: key);

  @override
  State<TicketListPage> createState() => _TicketListPageState();
}

class _TicketListPageState extends State<TicketListPage> {
  List<Datum> ticketList = [];
  List<Person> allUsersList = [];
  FilterParams filterParams = FilterParams.initial();
  Map<String, dynamic> userInfoData = {};
  bool? isLoading;

  @override
  void didChangeDependencies() async {
    setLoader(true);
    await fetchAndSetTicketData();
    await getUserDataFromToken();
    allUsersList = await fetchAllUsers();
    filterParams.userList = allUsersList;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(userInfoData: userInfoData),
      appBar: AppBar(
        shadowColor: Colors.black,
        elevation: 4,
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.black87),
        title: TextFormField(
          decoration: const InputDecoration(
              hintText: "Search Tickets", border: InputBorder.none),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => FilterWidget(
                        filterParams: filterParams,
                        filterData: filterTicketData,
                      ),
                    ));
              },
              icon: const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Icon(
                  Icons.filter_alt_outlined,
                  color: Colors.black,
                ),
              )),
        ],
      ),
      body: isLoading!
          ? _buildLoadingIndicator()
          : ticketList.isNotEmpty
              ? _buildTicketList()
              : noTicketFoundWidget(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(212, 255, 28, 11),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const TicketPageScreen(),
              )).then((value) {
            if (value) {
              fetchAndSetTicketData();
              // setState (() {});

            }
          });
        },
        child: const Icon(Icons.add, size: 36),
      ),
    );
  }

  Widget _buildTicketList() {
    return ListView.builder(
        itemCount: ticketList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              TicketCard(
                status1: ticketList[index].status,
                stattus: '',
                ticketItem: ticketList[index].userTicketItem,
                ticketBillofMaterial:
                    ticketList[index].userTicketBillOfMaterial,
                ticketCause: ticketList[index].userTicketCause,
                ticketDescription: ticketList[0].userTicketDescription,
              ),
              if (index == ticketList.length - 1)
                const SizedBox(
                  height: 160,
                )
            ],
          );
        });
  }

  Widget noTicketFoundWidget() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Image(image: AssetImage('assets/image/ticket_no.png')),
          Text(
            'No Tickets Found',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      child: const SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(
          color: Colors.red,
          strokeWidth: 2.8,
        ),
      ),
    );
  }

  Future<void> filterTicketData(
    Map<String, dynamic>? data,
    FilterParams filter,
  ) async {
    setLoader(true);
    filterParams = filter;
    filterParams.userList = allUsersList;
    await fetchAndSetTicketData(
      filterData: data,
    );
  }

  Future<void> fetchAndSetTicketData({Map? filterData}) async {
    await fetchAllTicketData(
      filterData: filterData,
    ).then((response) {
      var responseBody = jsonDecode(response.body);
      if (responseBody['meta']['code'] == 200 && responseBody['data'] is List) {
        ticketList.clear();
        responseBody['data'].forEach((data) {
          ticketList.add(Datum.fromJson(data));
        });
      } else {
        ticketList.clear();
      }
    });
    setLoader(false);
  }

  Future<http.Response> fetchAllTicketData({
    Map? filterData,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    // logPrint.w(token, '109999');

    final response = await http.post(
      Uri.parse('https://oneplusapi.acceso.in/ticket/getTicket'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token!,
      },
      body: jsonEncode(filterData == null
          ? {}
          : {
              'user_ticket_id': '',
              'created_by_id': filterData['created_by_id'],
              'ticket_status': filterData['status'],
              'to_date': filterData['end_date'],
              'from_date': filterData['start_date'],
            }),
    );

    var temp = jsonDecode(response.body);
    await prefs.setString('token', temp["token"]);
    return response;
  }

  Future<List<Person>> fetchAllUsers() async {
    final String? token = await getToken();

    final response = await http.post(
      Uri.parse('https://oneplusapi.acceso.in/users/getUserListForFilters'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token ?? "",
      },
    );

    var responseBody = jsonDecode(response.body);
    if (responseBody['meta']['code'] == 200 && responseBody['data'] is List) {
      final List result = responseBody['data'];
      return result.map((e) => Person.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<void> getUserDataFromToken() async {
    final String? token = await getToken();

    userInfoData = json.decode(
        ascii.decode(base64.decode(base64.normalize(token!.split(".")[1]))));
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    return token;
  }

  void setLoader(bool value) {
    setState(() {
      isLoading = value;
    });
  }
}
