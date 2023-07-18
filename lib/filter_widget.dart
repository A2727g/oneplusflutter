import 'package:tickets/utils/constants.dart';
import 'package:tickets/model/get_user_filter.dart';
import 'model/filter_params_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum DateType { from, to }

class FilterWidget extends StatefulWidget {
  const FilterWidget(
      {Key? key, required this.filterParams, required this.filterData})
      : super(key: key);

  final FilterParams? filterParams;

  final void Function(Map<String, dynamic>? data, FilterParams filterParams)
      filterData;

  @override
  FilterWidgetState createState() => FilterWidgetState();
}

class FilterWidgetState extends State<FilterWidget> {
  DateTime selectedDate = DateTime.now();
  DateTime selectedFromDate = DateTime.now();
  late FilterParams filterParams;
  Person? selectedPerson;

  var dateto = '';
  var datefrom = '';
  var status = '';
  var user = '';

  Map<String, dynamic> filterMap = {
    'start_date': '',
    'end_date': '',
    'status': '',
    'user': '',
    'user_ticket_id': '',
    'created_by_id': ''
  };

  @override
  void initState() {
    super.initState();
    filterParams = widget.filterParams!;
    _getStatuses();
  }

  _getStatuses() async {}

  Future<void> _selectDate(BuildContext context, DateType type) async {
    const MaterialColor buttonTextColor = MaterialColor(
      0xFF5252FF,
      <int, Color>{
        50: Color(0xFF5252FF),
        100: Color(0xFF5252FF),
        200: Color(0xFF5252FF),
        300: Color(0xFF5252FF),
        400: Color(0xFF5252FF),
        500: Color(0xFF5252FF),
        600: Color(0xFF5252FF),
        700: Color(0xFF5252FF),
        800: Color(0xFF5252FF),
        900: Color(0xFF5252FF),
      },
    );
    String date =
        type == DateType.from ? filterParams.fromDate! : filterParams.toDate!;
    if (date.isEmpty) {
      date = DateTime.now().toString();
    }
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(date),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      builder: (BuildContext context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
              primaryColor: const Color.fromRGBO(241, 67, 54, 1),
              colorScheme: ColorScheme.fromSwatch(
                      primarySwatch: buttonTextColor)
                  .copyWith(secondary: const Color.fromRGBO(241, 67, 54, 1))),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        if (type == DateType.from) {
          selectedFromDate = picked;
          filterParams = filterParams.copyWith(
              fromDate: DateFormat('yyyy-MM-dd').format(picked));
        } else {
          selectedDate = picked;
          filterParams = filterParams.copyWith(
              toDate: DateFormat('yyyy-MM-dd').format(picked));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(232, 236, 244, 1),
        appBar: AppBar(
          title: const Text(
            "Filter by",
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 44),
          decoration: const BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 14.0,
            ),
          ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                    filterParams.fromDate = DateTime.now().toString();
                    filterParams.toDate = DateTime.now().toString();
                    filterParams.selectedStatus = '';
                    filterParams.selectedUser = '';
                    widget.filterData(null, filterParams);
                  },
                  child: const Text(
                    "Remove Filter",
                    style: TextStyle(
                        color: Color.fromRGBO(241, 67, 54, 1),
                        fontWeight: FontWeight.w700),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(132, 48),
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Colors.redAccent,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(14)),
                    backgroundColor: const Color.fromRGBO(241, 67, 54, 1),
                  ),
                  onPressed: () async {
                    setDataToFilterMap();
                  },
                  child: const Text(
                    "Apply",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w900),
                  )),
            ],
          ),
        ),
        body: Row(
          children: [
            Container(
              width: width * .3,
              color: Colors.white,
              child: Column(
                children: [
                  InkWell(
                      onTap: () {
                        setState(() {
                          filterParams = filterParams.copyWith(
                              selectedFilter: SelectedFilter.date);
                        });
                      },
                      child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          color:
                              filterParams.selectedFilter == SelectedFilter.date
                                  ? const Color.fromRGBO(
                                      241,
                                      67,
                                      54,
                                      1,
                                    )
                                  : null,
                          child: Text(
                            "Date",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: filterParams.selectedFilter ==
                                        SelectedFilter.date
                                    ? Colors.white
                                    : null),
                          ))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          filterParams = filterParams.copyWith(
                              selectedFilter: SelectedFilter.status);
                        });
                      },
                      child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          color: filterParams.selectedFilter ==
                                  SelectedFilter.status
                              ? Colors.redAccent
                              : null,
                          child: Text(
                            "Status",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: filterParams.selectedFilter ==
                                        SelectedFilter.status
                                    ? Colors.white
                                    : null),
                          ))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          filterParams = filterParams.copyWith(
                              selectedFilter: SelectedFilter.user);
                        });
                      },
                      child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          color:
                              filterParams.selectedFilter == SelectedFilter.user
                                  ? Colors.redAccent
                                  : null,
                          child: Text(
                            "User",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: filterParams.selectedFilter ==
                                        SelectedFilter.user
                                    ? Colors.white
                                    : null),
                          ))),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(232, 236, 244, 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 14.0,
                      ),
                    ]),
                child: Column(
                  children: [
                    if (filterParams.selectedFilter == SelectedFilter.date)
                      Padding(
                        padding: const EdgeInsets.all(21),
                        child: Column(
                          children: [
                            InkWell(
                                onTap: () =>
                                    _selectDate(context, DateType.from),
                                child: Container(
                                    width: width * 0.5,
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.grey[200]!,
                                        )),
                                    child: Row(
                                      children: [
                                        Text(
                                          "To           ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey[500]),
                                        ),
                                        Text(
                                          filterParams.fromDate == ''
                                              ? ''
                                              : DateFormat("dd/MM/yyyy").format(
                                                  DateTime.parse(
                                                      filterParams.fromDate!)),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                      ],
                                    ))),
                            const SizedBox(
                              height: 32,
                            ),
                            InkWell(
                                onTap: () => _selectDate(context, DateType.to),
                                child: Container(
                                    width: width * 0.5,
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(
                                          10,
                                        )),
                                        border: Border.all(
                                          color: Colors.grey[200]!,
                                        )),
                                    child: Row(
                                      children: [
                                        Text(
                                          "From       ",
                                          style: TextStyle(
                                              color: Colors.grey[500]),
                                        ),
                                        Text(
                                          filterParams.toDate == ''
                                              ? ''
                                              : DateFormat(
                                                  "dd/MM/yyyy",
                                                ).format(DateTime.parse(
                                                  filterParams.toDate!)),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                      ],
                                    ))),
                          ],
                        ),
                      ),
                    if (filterParams.selectedFilter == SelectedFilter.status)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(filterParams.statusList!.length,
                            (index) {
                          var status = filterParams.statusList![index];
                          return Row(
                            children: [
                              Checkbox(
                                  activeColor: Colors.redAccent,
                                  value: status == filterParams.selectedStatus,
                                  onChanged: (val) {
                                    _onStatusChanged(val, status);
                                    logPrint.w(status, 'asdf');
                                    status = val;
                                  }),
                              Text(status)
                            ],
                          );
                        }),
                      ),
                    if (filterParams.selectedFilter == SelectedFilter.user)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(filterParams.userList!.length,
                            (index) {
                          var status =
                              filterParams.userList![index].user_first_name;
                          return Row(
                            children: [
                              Checkbox(
                                  activeColor: Colors.redAccent,
                                  value: status == filterParams.selectedUser,
                                  onChanged: (val) {
                                    selectedPerson =
                                        filterParams.userList![index];
                                    _onUserChanged(val, status);
                                  }),
                              Text(status ?? '')
                            ],
                          );
                        }),
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _onStatusChanged(bool? newValue, String? selectedStatus) => setState(() {
        if (newValue!) {
          filterParams = filterParams.copyWith(selectedStatus: selectedStatus);
        } else {
          filterParams = filterParams.copyWith(selectedStatus: '');
        }
      });

  _onUserChanged(bool? newValue, String? selectedUser) => setState(() {
        if (newValue!) {
          filterParams = filterParams.copyWith(selectedUser: selectedUser);
        } else {
          filterParams = filterParams.copyWith(selectedUser: '');
        }
      });

  void setDataToFilterMap() {
    bool isFromAndToDateIdentical = selectedFromDate.toString().split(' ')[0] ==
        selectedDate.toString().split(' ')[0];

    if (!isFromAndToDateIdentical) {
      filterMap['end_date'] = selectedFromDate.toString().split(' ')[0];
      filterMap['start_date'] = selectedDate.toString().split(' ')[0];
    }

    if (filterParams.selectedStatus != null &&
        filterParams.selectedStatus != "") {
      filterMap['status'] =
          "${filterParams.selectedStatus![0].toUpperCase()}${filterParams.selectedStatus!.substring(1, filterParams.selectedStatus!.length).toLowerCase()}";
    }

    if (selectedPerson != null) {
      filterMap['created_by_id'] =
          selectedPerson != null ? selectedPerson!.user_id : null;
    }

    Navigator.of(context).pop();
    widget.filterData(filterMap, filterParams);
  }
}
