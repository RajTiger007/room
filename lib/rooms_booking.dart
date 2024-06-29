// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// enum RoomType { singleAC, doubleAC }

// class Room {
//   final String id;
//   final RoomType roomType;
//   final bool isAvailable;
//   final String status;

//   Room({
//     required this.id,
//     required this.roomType,
//     required this.isAvailable,
//     required this.status,
//   });
// }

// class Floor {
//   final int number;
//   final List<Room> rooms;

//   Floor({
//     required this.number,
//     required this.rooms,
//   });
// }

// class RoomBookingPage extends StatefulWidget {
//   const RoomBookingPage({super.key});

//   @override
//   _RoomBookingPageState createState() => _RoomBookingPageState();
// }

// class _RoomBookingPageState extends State<RoomBookingPage> {
//   int selectedYear = DateTime.now().year;
//   int selectedMonth = DateTime.now().month;
//   int rows = 5;
//   int selectedFloor = 1; // Default selected floor
//   late int columns;
//   final int totalFloors = 4;

//   late List<Floor> floors;
//   late List<List<bool>> _selectedCells;
//   String? _currentToken;

//   static const Map<String, Color> _statusColors = {
//     'available': Color(0xFFE0F7FA),
//     'booked': Color(0xFF80CBC4),
//     'maintenance': Color(0xFFB0BEC5),
//     'selected': Color(0xFF4DB6AC),
//   };

//   static const Map<String, IconData> _statusIcons = {
//     'available': Icons.check_box_outline_blank,
//     'booked': Icons.event_busy,
//     'maintenance': Icons.build,
//     'selected': Icons.check_box,
//   };

//   static const Map<RoomType, String> _roomTypes = {
//     RoomType.singleAC: 'Single AC',
//     RoomType.doubleAC: 'Double AC',
//   };

//   @override
//   void initState() {
//     super.initState();
//     _initializeGrid();
//   }

//   void _initializeGrid() {
//     setState(() {
//       columns = DateTime(selectedYear, selectedMonth + 1, 0).day;
//       floors = [
//         Floor(
//           number: 1,
//           rooms: [
//             Room(id: 'F1_R1', roomType: RoomType.singleAC, isAvailable: true, status: 'available'),
//             Room(id: 'F1_R2', roomType: RoomType.doubleAC, isAvailable: true, status: 'available'),
//             Room(id: 'F1_R3', roomType: RoomType.singleAC, isAvailable: false, status: 'maintenance'),
//             Room(id: 'F1_R4', roomType: RoomType.doubleAC, isAvailable: true, status: 'available'),
//             Room(id: 'F1_R5', roomType: RoomType.singleAC, isAvailable: true, status: 'available'),
//           ],
//         ),
//         Floor(
//           number: 2,
//           rooms: [
//             Room(id: 'F2_R1', roomType: RoomType.doubleAC, isAvailable: true, status: 'available'),
//             Room(id: 'F2_R2', roomType: RoomType.singleAC, isAvailable: false, status: 'maintenance'),
//             Room(id: 'F2_R3', roomType: RoomType.doubleAC, isAvailable: true, status: 'available'),
//             Room(id: 'F2_R4', roomType: RoomType.singleAC, isAvailable: true, status: 'available'),
//             Room(id: 'F2_R5', roomType: RoomType.doubleAC, isAvailable: true, status: 'available'),
//           ],
//         ),
//         Floor(
//           number: 3,
//           rooms: [
//             Room(id: 'F3_R1', roomType: RoomType.singleAC, isAvailable: true, status: 'available'),
//             Room(id: 'F3_R2', roomType: RoomType.doubleAC, isAvailable: true, status: 'available'),
//             Room(id: 'F3_R3', roomType: RoomType.singleAC, isAvailable: true, status: 'available'),
//             Room(id: 'F3_R4', roomType: RoomType.doubleAC, isAvailable: false, status: 'maintenance'),
//             Room(id: 'F3_R5', roomType: RoomType.singleAC, isAvailable: true, status: 'available'),
//           ],
//         ),
//         Floor(
//           number: 4,
//           rooms: [
//             Room(id: 'F4_R1', roomType: RoomType.doubleAC, isAvailable: true, status: 'available'),
//             Room(id: 'F4_R2', roomType: RoomType.singleAC, isAvailable: true, status: 'available'),
//             Room(id: 'F4_R3', roomType: RoomType.doubleAC, isAvailable: true, status: 'available'),
//             Room(id: 'F4_R4', roomType: RoomType.singleAC, isAvailable: true, status: 'available'),
//             Room(id: 'F4_R5', roomType: RoomType.doubleAC, isAvailable: false, status: 'maintenance'),
//           ],
//         ),
//       ];
//       _selectedCells = List.generate(
//         totalFloors,
//         (_) => List.generate(rows, (_) => false),
//       );
//     });
//   }

//   void _updateGrid() {
//     _initializeGrid();
//   }

//   void _generateToken() {
//     _currentToken =
//         '${DateTime.now().year}_${DateTime.now().month}_${DateTime.now().day}_${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}';
//   }

//   void _toggleRoomStatus(int floorIndex, int roomIndex) {
//     setState(() {
//       if (floors[floorIndex].rooms[roomIndex].status == 'booked') {
//         return; // Do nothing if the room is already booked
//       }
//       if (floors[floorIndex].rooms[roomIndex].status == 'selected') {
//         floors[floorIndex].rooms[roomIndex].status = 'available';
//       } else {
//         floors[floorIndex].rooms[roomIndex].status = 'selected';
//         _generateToken();
//       }
//     });
//   }

//   void _confirmBooking() {
//     setState(() {
//       for (Floor floor in floors) {
//         for (Room room in floor.rooms) {
//           if (room.status == 'selected') {
//             room.status = 'booked';
//           }
//         }
//       }
//     });
//   }

//   void _showSelectedRoomsPopup() {
//     List<String> selectedRooms = [];
//     for (Floor floor in floors) {
//       for (Room room in floor.rooms) {
//         if (room.status == 'selected') {
//           selectedRooms.add('${room.id}');
//         }
//       }
//     }

//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text('Token ID: $_currentToken'),
//             ),
//             Divider(),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text('Selected Rooms:'),
//             ),
//             Expanded(
//               child: Scrollbar(
//                 thumbVisibility: true,
//                 thickness: 10,
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.vertical,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Wrap(
//                       spacing: 8.0,
//                       runSpacing: 8.0,
//                       children: selectedRooms.map((room) {
//                         return Container(
//                           padding: EdgeInsets.all(8.0),
//                           color: Colors.teal[300],
//                           child: Text(room),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             if (selectedRooms.isNotEmpty)
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       elevation: 12.0,
//                       backgroundColor: Colors.teal[600],
//                       textStyle: const TextStyle(color: Colors.white)),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     _showBookingForm(); // Show booking form after clicking "Book"
//                   },
//                   child:
//                       Text('Book Rooms', style: TextStyle(color: Colors.white)),
//                 ),
//               ),
//           ],
//         );
//       },
//     );
//   }

//   void _showBookingForm() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           scrollable: true,
//           title: Text('Booking'),
//           content: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Form(
//               child: Column(
//                 children: <Widget>[
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Name',
//                       icon: Icon(Icons.account_box),
//                     ),
//                   ),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Email',
//                       icon: Icon(Icons.email),
//                     ),
//                   ),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Mobile Number',
//                       icon: Icon(Icons.phone),
//                     ),
//                   ),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Extra Bed',
//                       icon: Icon(Icons.bed),
//                     ),
//                   ),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Meal Plan',
//                       icon: Icon(Icons.restaurant),
//                     ),
//                   ),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'No. of Occupants',
//                       icon: Icon(Icons.person),
//                     ),
//                   ),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Purpose of Visit',
//                       icon: Icon(Icons.travel_explore),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             ElevatedButton(
//                 child: Text("Submit"),
//                 onPressed: () {
//                   _confirmBooking();
//                   Navigator.of(context).pop();
//                   _showConfirmationPopup();
//                 }),
//             ElevatedButton(
//                 child: Text("Cancel"),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 })
//           ],
//         );
//       },
//     );
//   }

//   void _showConfirmationPopup() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Booking Confirmed'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Text('Your booking has been confirmed.'),
//               SizedBox(height: 16.0),
//               Icon(Icons.check_circle_outline,
//                   size: 48.0, color: Colors.teal[600]),
//             ],
//           ),
//           actions: [
//             ElevatedButton(
//               child: Text("OK"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   List<TableRow> _buildTableRows() {
//     List<Room> currentFloorRooms =
//         floors.firstWhere((floor) => floor.number == selectedFloor).rooms;

//     return List.generate(rows, (rowIndex) {
//       return TableRow(
//         children: List.generate(columns, (colIndex) {
//           int roomIndex = rowIndex * columns + colIndex;
//           Room room = currentFloorRooms[roomIndex];
//           return InkWell(
//             onTap: room.isAvailable
//                 ? () {
//                     _toggleRoomStatus(selectedFloor - 1, roomIndex);
//                   }
//                 : null,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: _statusColors[room.status],
//                 border: Border.all(color: Colors.black, width: 0.5),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     _statusIcons[room.status],
//                     color: room.isAvailable ? Colors.black : Colors.grey,
//                   ),
//                   Text(
//                     room.id,
//                     style: TextStyle(
//                       fontSize: 8,
//                       color: room.isAvailable ? Colors.black : Colors.grey,
//                     ),
//                   ),
//                   Text(
//                     _roomTypes[room.roomType] ?? '',
//                     style: TextStyle(
//                       fontSize: 8,
//                       color: room.isAvailable ? Colors.black : Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Room Booking Grid'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               IconButton(
//                 icon: Icon(Icons.arrow_back),
//                 onPressed: () {
//                   setState(() {
//                     selectedMonth = (selectedMonth > 1) ? selectedMonth - 1 : 12;
//                     if (selectedMonth == 12) selectedYear--;
//                     _updateGrid();
//                   });
//                 },
//               ),
//               Text(
//                 DateFormat('MMMM yyyy').format(DateTime(selectedYear, selectedMonth)),
//                 style: TextStyle(fontSize: 18.0),
//               ),
//               IconButton(
//                 icon: Icon(Icons.arrow_forward),
//                 onPressed: () {
//                   setState(() {
//                     selectedMonth = (selectedMonth < 12) ? selectedMonth + 1 : 1;
//                     if (selectedMonth == 1) selectedYear++;
//                     _updateGrid();
//                   });
//                 },
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(totalFloors, (index) {
//               return ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     selectedFloor = index + 1;
//                   });
//                 },
//                 child: Text('Floor ${index + 1}'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: selectedFloor == index + 1 ? Colors.teal[600] : Colors.grey,
//                   elevation: 8.0,
//                 ),
//               );
//             }),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Table(
//                 defaultColumnWidth: FixedColumnWidth(70.0),
//                 border: TableBorder.all(color: Colors.black, width: 1.0),
//                 children: _buildTableRows(),
//               ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showSelectedRoomsPopup,
//         child: const Icon(Icons.check),
//       ),
//     );
//   }
// }
