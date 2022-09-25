import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:hotel_project/rooms_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
  DateTime checkInDateTime = DateTime.now();
  DateTime checkOutDateTime = DateTime.now();
  double childrenRating = 0;
  double adultRating = 0;
  List<String> extrasCheckedItems = [];
  String? selectedView = '';
}

class _HomeScreenState extends State<HomeScreen> {
  Future selectedCheckInDate(context) async {
    final DateTime? piked = await showDatePicker(
      context: context,
      initialDate: widget.checkInDateTime,
      firstDate: DateTime(1990),
      lastDate: DateTime(2040),
    );
    if (piked != null && piked != widget.checkInDateTime) {
      setState(() {
        widget.checkInDateTime = piked;
      });
    }
  }

  Future selectedCheckOutDate(context) async {
    final DateTime? piked = await showDatePicker(
      context: context,
      initialDate: widget.checkOutDateTime,
      firstDate: DateTime(1990),
      lastDate: DateTime(2040),
    );
    if (piked != null && piked != widget.checkOutDateTime) {
      setState(() {
        widget.checkOutDateTime = piked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hilton Hotel',
          style: TextStyle(
              fontSize: 26,
              color: Colors.white,
              fontFamily: 'Dance',
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          fit: StackFit.loose,
          children: [
            ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Image(
                      image: NetworkImage(
                          'https://img.freepik.com/free-photo/scenic-view-sandy-beach-beach-with-sun-beds-umbrellas-open-against-sea-mountains-hotel-resort-tekirova-kemer-turkey_146671-18876.jpg?w=1060&t=st=1663757972~exp=1663758572~hmac=a64365590970fbf0c63ecfc71ba75842003728bb0adfb0da1a1d0ca30b6b46ba'),
                      fit: BoxFit.cover,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Check-in date:',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        IconButton(
                          onPressed: () {
                            selectedCheckInDate(context);
                          },
                          icon: const Icon(
                            Icons.date_range,
                            size: 26,
                          ),
                        ),
                        Text(
                            '${widget.checkInDateTime.year} / ${widget.checkInDateTime.month} / ${widget.checkInDateTime.day}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.w700,
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Check-out date:',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            selectedCheckOutDate(context);
                          },
                          icon: const Icon(
                            Icons.date_range,
                            size: 26,
                          ),
                        ),
                        Text(
                            '${widget.checkOutDateTime.year} / ${widget.checkOutDateTime.month} / ${widget.checkOutDateTime.day}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.w700,
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Number of Adults:',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.w700,
                            )),
                        const SizedBox(
                          width: 16,
                        ),
                        Slider(
                          value: widget.adultRating,
                          autofocus: true,
                          onChanged: (newRating) {
                            setState(() {
                              widget.adultRating = newRating;
                            });
                          },
                          min: 0,
                          max: 10,
                          divisions: 10,
                          label: widget.adultRating.toInt().toString(),
                          activeColor: Colors.lightBlue,
                          inactiveColor: Colors.blue[100],
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Expanded(
                          child: Text(widget.adultRating.toInt().toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.lightBlue,
                                fontWeight: FontWeight.w700,
                              )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Number of Children:',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.w700,
                            )),
                        const SizedBox(
                          width: 5,
                        ),
                        Slider(
                          value: widget.childrenRating,
                          onChanged: (newRating) {
                            setState(() {
                              widget.childrenRating = newRating;
                            });
                          },
                          min: 0,
                          max: 10,
                          divisions: 10,
                          label: widget.childrenRating.toInt().toString(),
                          activeColor: Colors.lightBlue,
                          inactiveColor: Colors.blue[100],
                          autofocus: true,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(widget.childrenRating.toInt().toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.w700,
                            )),
                      ],
                    ),
                    const Text(
                      'Extras:',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    CheckboxGroup(
                      labels: const [
                        'Breakfast (50EGP/Day)',
                        'Internet WiFi (50EGP/Day)',
                        'Parking (100EGP/Day)',
                      ],
                      onSelected: (checked) {
                        widget.extrasCheckedItems = checked;
                        print(checked.toString());
                      },
                    ),
                    const Text(
                      'View:',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    RadioButtonGroup(
                      labels: const ['Garden View', 'Sea View'],
                      onSelected: (selected) {
                        widget.selectedView = selected;
                        print(selected.toString());
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Rooms(
                                          adultRating: widget.adultRating,
                                          checkInDateTime:
                                              widget.checkInDateTime,
                                          checkOutDateTime:
                                              widget.checkOutDateTime,
                                          childrenRating: widget.childrenRating,
                                          selectedView: widget.selectedView,
                                          extrasCheckedItems:
                                              widget.extrasCheckedItems,
                                        )),
                                (route) => false);
                          },
                          color: Colors.lightBlueAccent,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text('Check Rooms and Rates',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
