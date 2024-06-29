import 'package:flutter/material.dart';
import 'package:room_booking/src/easy_infinite_date_time/easy_infinite_date_timeline.dart';
import 'package:room_booking/src/easy_infinite_date_time/widgets/infinite_time_line_widget.dart';
import 'package:room_booking/src/properties/day_style.dart';
import 'package:room_booking/src/properties/easy_day_props.dart';
import 'package:room_booking/src/properties/easy_header_props.dart';
import 'package:room_booking/src/utils/easy_date_formatter.dart';
import 'package:room_booking/src/widgets/easy_date_timeline_widget/easy_date_timeline_widget.dart';

void main() {
  runApp(const MyApp());
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
            title: Text(
              "Room Booking",
            ),
          ),
          body: DateGrid(),
        ));
  }
}

class DateGrid extends StatelessWidget {
  const DateGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    EasyInfiniteDateTimelineController controller =
        EasyInfiniteDateTimelineController();
    return Container(
        child: SingleChildScrollView(
      child: Column(
        children: [
          EasyDateTimeLine(initialDate: DateTime.now()),
          EasyDateTimeLine(
            initialDate: DateTime.now(),
            onDateChange: (selectedDate) {
              //`selectedDate` the new date selected.
            },
            activeColor: const Color(0xffFFBF9B),
            headerProps: const EasyHeaderProps(
                // selectedDateFormat: SelectedDateFormat.monthOnly,
                ),
            dayProps: const EasyDayProps(
              height: 56.0,
              width: 56.0,
              dayStructure: DayStructure.dayNumDayStr,
              inactiveDayStyle: DayStyle(
                borderRadius: 48.0,
                dayNumStyle: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              activeDayStyle: DayStyle(
                dayNumStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Text(" hi how$controller "),
          EasyInfiniteDateTimeLine(
            controller: controller,
            firstDate: DateTime.now(),
            focusDate: DateTime(29),
            lastDate: DateTime(2026, 12, 31),
            itemBuilder: (
              BuildContext context,
              DateTime date,
              bool isSelected,
              VoidCallback onTap,
            ) {
              Color fillColor = const Color.fromARGB(255, 219, 54, 244);

              return InkResponse(
                // You can use `InkResponse` to make your widget clickable.
                // The `onTap` callback responsible for triggering the `onDateChange`
                // callback and animating to the selected date if the `selectionMode` is
                // SelectionMode.autoCenter() or SelectionMode.alwaysFirst().
                onTap: onTap,
                child: CircleAvatar(
                  // use `isSelected` to specify whether the widget is selected or not.
                  backgroundColor:
                      isSelected ? fillColor : fillColor.withOpacity(0.1),
                  radius: 32.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(
                            color: isSelected ? Colors.white : null,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          EasyDateFormatter.shortDayName(date, "en_US"),
                          style: TextStyle(
                            color: isSelected ? Colors.white : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ));
  }
}
