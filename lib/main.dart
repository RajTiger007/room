import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:room_booking/utiliity/datetime_utility.dart';
import 'package:room_booking/utiliity/screen.dart';
import 'package:room_booking/widgets/dropdown.dart';

void main() {
  initializeDateFormatting('pt_BR', '').then((_) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        themeMode: ThemeMode.light,
        home: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Room Booking",
            ),
          ),
          body: const DateGrid(),
        ));
  }
}

class DateGrid extends StatefulWidget {
  const DateGrid({
    super.key,
  });

  @override
  State<DateGrid> createState() => _DateGridState();
}

// ////////////

class _DateGridState extends State<DateGrid> {
  ScrollController dateTimeScrollController = ScrollController();

  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;

  String? dropdownValue;

  late DateTime daysASColumns;
  late int _daysCount;

  late ValueNotifier<int?> currentMonth;
  late ValueNotifier<int?> currentYear;

  _initializeGrid() {
    daysASColumns = DateTime(selectedYear, selectedMonth + 1, 0);
    _daysCount =
        DTUtility.calculateDaysCount(DateTime.now(), DateTime(2026, 12, 31));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeGrid();
    currentMonth = ValueNotifier<int?>(selectedMonth);
    currentYear = ValueNotifier<int?>(selectedYear);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollToCurrentDate();
    });
  }

  @override
  void dispose() {
    dateTimeScrollController.dispose();
    super.dispose();
  }

  void _scrollToCurrentDate() {
    int _currentDay;
    _currentDay = DTUtility.getCurrentDate();
    int viewWidth = (ScreenUtility.GetScreenWdth(context) / 2).floor();

    if (_currentDay >= 0 && _currentDay < 30) {
      // Adjust according to your days count
      double offset = (_currentDay * 50.0) -
          viewWidth; // Assuming each item is 50 pixels tall
      dateTimeScrollController.animateTo(
        offset,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     IconButton(
        //       icon: Icon(Icons.arrow_back),
        //       onPressed: () {
        //         setState(() {
        //           selectedMonth = (selectedMonth > 1) ? selectedMonth - 1 : 12;
        //           if (selectedMonth == 12) selectedYear--;
        //           _updateGrid();
        //         });
        //       },
        //     ),
        //     Text(
        //       DateFormat('MMMM yyyy').format(DateTime(selectedYear, selectedMonth)),
        //       style: TextStyle(fontSize: 18.0),
        //     ),
        //     IconButton(
        //       icon: Icon(Icons.arrow_forward),
        //       onPressed: () {
        //         setState(() {
        //           selectedMonth = (selectedMonth < 12) ? selectedMonth + 1 : 1;
        //           if (selectedMonth == 1) selectedYear++;
        //           _updateGrid();
        //         });
        //       },
        //     ),
        //   ],
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: List.generate(totalFloors, (index) {
        //     return ElevatedButton(
        //       onPressed: () {
        //         setState(() {
        //           selectedFloor = index + 1;
        //         });
        //       },
        //       child: Text('Floor ${index + 1}'),
        //       style: ElevatedButton.styleFrom(
        //         backgroundColor: selectedFloor == index + 1 ? Colors.teal[600] : Colors.grey,
        //         elevation: 8.0,
        //       ),
        //     );
        //   }),
        // ),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CompactDropdown(
                    items: [selectedYear,selectedYear+1].map((int value) {
                      return value.toString();
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                      // Suggested code may be subject to a license. Learn more: ~LicenseLog:4174253022.
                    },
                    initialValue: 'Select years',
                  ),
                  CompactDropdown(
                    items: months,
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    initialValue: 'select months',
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(currentYear.value!.toString()),
                  Text(months[currentMonth.value! - 1].toString()),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ValueListenableBuilder<int?>(
                  valueListenable: currentMonth,
                  builder: (context, value, child) => Column(
                    children: [
                      Table(
                        defaultColumnWidth:
                            FixedColumnWidth(MediaQuery.of(context).size.width),
                        border:
                            TableBorder.all(color: Colors.black, width: 1.0),
                        children: [_buildHeader()],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  TableRow _buildHeader() {
    void scrollToPosition() {
      dateTimeScrollController.animateTo(
        100 * 50,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }

    dateTimeScrollController.addListener(() {
      if (dateTimeScrollController.position.pixels ==
          dateTimeScrollController.position.maxScrollExtent) {
        scrollToPosition();
      }

      // Calculate the month based on the scroll position
      int currentDay = (dateTimeScrollController.offset / 50).floor();
      int month = DateTime(selectedYear, selectedMonth, currentDay + 1).month;
      currentMonth.value = month;
      // log("current day:;$currentDay*12");
      currentYear.value =
          DateTime(selectedYear, selectedMonth, currentDay + 1).year;
      log("current year:;$currentYear");
    });

    return TableRow(
      children: [
        SizedBox(
          height: 50.0,
          child: ListView.builder(
            controller: dateTimeScrollController,
            scrollDirection: Axis.horizontal,
            itemCount: _daysCount,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const SizedBox(width: 50); // Placeholder for "Rooms"
              }

              DateTime date = DateTime(selectedYear, selectedMonth, index);
              String dateStr = DateFormat('EEE\nd').format(date);
              log(dropdownValue.toString());

              return _buildHeaderCell(dateStr);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderCell(String text) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.teal),
        color: Colors.teal[700],
      ),
      child: Text(
        text,
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }
}
