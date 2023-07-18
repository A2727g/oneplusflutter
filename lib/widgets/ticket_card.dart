import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tickets/utils/constants.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({
    super.key,
    this.ticketItem,
    this.ticketBillofMaterial,
    this.ticketCause,
    this.ticketDescription,
    this.status1,
    this.stattus,
    this.dateTime,
  });
  final String? ticketItem;
  final String? ticketBillofMaterial;
  final String? ticketCause;
  final String? ticketDescription;
  final String? status1;
  final String? stattus;
  final String? dateTime;

  static const Map<String, Color> statusColorMap = {
    'open': ColorConstants.openStatus,
    'close': ColorConstants.closeStatus,
    'pending': ColorConstants.pendingStatus,
    'in process': ColorConstants.inProcessStatus,
  };

  static const Map<String, Color> ticketColorMap = {
    'e': ColorConstants.eTicketName,
    'a': ColorConstants.aTicketName,
    'w': ColorConstants.wTicketName,
    'c': ColorConstants.cTicketName,
  };

  static const Map<String, Color> status2ColorMap = {
    'expedite': ColorConstants.expediteStatus2,
  };

  static const Map<String, Color> statusTextColorMap = {
    'expedite': ColorConstants.expediteStatusText,
  };

  static const Map<String, Color> status1ColorMap = {
    'open': ColorConstants.openStatus1,
    'close': ColorConstants.closeStatus1,
    'pending': ColorConstants.pendingStatus1,
    'in process': ColorConstants.inProcessStatus1,
  };

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    constraints: const BoxConstraints(
                      maxHeight: 44,
                      maxWidth: 44,
                    ),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey, width: 1),
                      color:
                          ticketDescription == null && ticketDescription == ""
                              ? ticketColorMap[ticketDescription!
                                      .substring(0, 1)
                                      .toLowerCase()]
                                  ?.withOpacity(0.7)
                              : null,
                    ),
                    child: Text(
                      ticketDescription != null && ticketDescription != ""
                          ? ticketDescription!.substring(0, 1)
                          : "",
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ' $ticketItem, $ticketBillofMaterial',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          '$ticketCause, $ticketDescription',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 133, 150, 164),
                              fontSize: 12),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                              decoration: BoxDecoration(
                                  border: const Border(),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                  color:
                                      statusColorMap[status1!.toLowerCase()]),
                              child: Text(
                                '$status1',
                                style: textTheme.caption!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 8,
                                    color: status1ColorMap[
                                        status1!.toLowerCase()]),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            if (stattus!.isNotEmpty &&
                                (status1 != null &&
                                    status1!.toLowerCase() == 'open'))
                              Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                  decoration: BoxDecoration(
                                    border: const Border(),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4)),
                                    color:
                                        status2ColorMap[stattus!.toLowerCase()]
                                            ?.withOpacity(0.5),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.flash_on_rounded,
                                        color: Color.fromARGB(255, 63, 196, 86),
                                        size: 10,
                                      ),
                                      Text(
                                        '$stattus',
                                        style: textTheme.caption!.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 8,
                                            color: statusTextColorMap[
                                                stattus!.toLowerCase()]),
                                      ),
                                    ],
                                  ))
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    color: Colors.black12,
                    height: 2,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat("  dd MMM yyyy hh:mm a")
                            .format(DateTime.now()),
                        textAlign: TextAlign.left,
                        style: textTheme.labelLarge!.copyWith(
                            color: const Color.fromARGB(255, 0, 136, 157),
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () => {},
                          icon: const Icon(
                            Icons.navigate_next,
                            color: Color.fromARGB(255, 0, 136, 157),
                          )),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
