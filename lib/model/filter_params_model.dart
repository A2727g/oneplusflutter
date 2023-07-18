import 'package:intl/intl.dart';
import 'package:tickets/model/get_user_filter.dart';

enum SelectedFilter { date, status, user }

class FilterParams {
  String? toDate = DateFormat('dd/MM/yy').format(DateTime.now());
  String? fromDate = DateFormat('dd/MM/yy').format(DateTime.now());
  List? statusList = [];
  List<Person>? userList = [];
  SelectedFilter? selectedFilter = SelectedFilter.date;
  String? selectedStatus = '';
  String? selectedUser = '';
  int? filterCount = 0;

  FilterParams._(
      {this.toDate,
      this.fromDate,
      this.statusList,
      this.userList,
      this.selectedFilter,
      this.selectedStatus,
      this.selectedUser,
      this.filterCount});

  FilterParams.initial({
    List? status = const ['OPEN', 'PENDING', 'CLOSED', 'IN PROCESS'],
  }) : this._(
            toDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
            fromDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
            statusList: status,
            selectedFilter: SelectedFilter.date,
            selectedStatus: '',
            selectedUser: '',
            filterCount: 0);

  FilterParams copyWith(
      {toDate,
      fromDate,
      statusList,
      userList,
      selectedFilter,
      selectedStatus,
      selectedUser}) {
    int count = 0;
    String tempDate = toDate ?? this.toDate;
    // String tempFromDate = fromDate ?? this.fromDate;
    String tempSelectedStatus = selectedStatus ?? this.selectedStatus;
    // String tempSelectedUser = selectedUser ?? this.selectedUser;
    if (
        // !_date.isNullOrEmpty
        DateFormat('yyyy-MM-dd').format(DateTime.now()) != tempDate) {
      count += 1;
    }
    if (tempSelectedStatus.isNotEmpty) {
      count += 1;
    }
    return FilterParams._(
        toDate: toDate ?? this.toDate,
        fromDate: fromDate ?? this.fromDate,
        statusList: statusList ?? this.statusList,
        userList: userList ?? this.userList,
        selectedFilter: selectedFilter ?? this.selectedFilter,
        selectedStatus: selectedStatus ?? this.selectedStatus,
        selectedUser: selectedUser ?? this.selectedUser,
        filterCount: count);
  }
}
