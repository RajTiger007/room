import 'package:flutter/material.dart';

/// Flutter code sample for [DropdownMenu].

// const List<String> list = <String>['One', 'Two', 'Three', 'Four'];


class CompactDropdown extends StatefulWidget {
  final List<String> items;
  final Function(String) onChanged;
  final String initialValue;

  const CompactDropdown({
    Key? key,
    required this.items,
    required this.onChanged,
    required this.initialValue,
  }) : super(key: key);

  @override
  _CompactDropdownState createState() => _CompactDropdownState();
}

class _CompactDropdownState extends State<CompactDropdown> {
  late String _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40, // Adjust this value to change the overall height
      decoration: BoxDecoration(
        color: Colors.teal[700],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white),
      ),
      child: PopupMenuButton<String>(
        initialValue: _selectedItem,
        onSelected: (String value) {
          setState(() {
            _selectedItem = value;
          });
          widget.onChanged(value);
        },
        itemBuilder: (BuildContext context) {
          return widget.items.map<PopupMenuItem<String>>((String value) {
            return PopupMenuItem<String>(
              value: value,
              child: Text(value, style: TextStyle(color: Colors.white)),
            );
          }).toList();
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedItem,
                style: TextStyle(color: Colors.white),
              ),
              Icon(Icons.arrow_drop_down, color: Colors.white),
            ],
          ),
        ),
        color: Colors.teal[700],
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}


// /////////////////////////////////////////////

class DropdownWidget extends StatefulWidget {
  List<String> items;
  Function(String?)? callBack;

  DropdownWidget({super.key, required this.items, required this.callBack});

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: widget.items.first,
      menuHeight: 120, // Reduced from 150
      width: 150,
      textStyle: TextStyle(color: Colors.white),
      onSelected: widget.callBack,
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(Colors.teal[700]),
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 5)), // Reduced padding
        visualDensity: VisualDensity.compact,
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), // Slightly reduced border radius
          borderSide: BorderSide(color: Colors.white),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8), // Added to reduce input field height
        hintStyle: TextStyle(color: Colors.white),
        labelStyle: TextStyle(color: Colors.white),
        iconColor: Colors.white,
        fillColor: Colors.teal[700],
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), // Slightly reduced border radius
        ),
      ),
      dropdownMenuEntries:
          widget.items.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(
          value: value,
          label: value,
          style: ButtonStyle(
            visualDensity: VisualDensity.compact,
            backgroundColor: WidgetStatePropertyAll(Colors.teal),
            textStyle: WidgetStatePropertyAll(TextStyle(color: Colors.white)),
            iconColor: WidgetStatePropertyAll(Colors.white),
            padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 10, vertical: 5)), // Added to reduce item height
          ),
        );
      }).toList(),
    );
  }
}