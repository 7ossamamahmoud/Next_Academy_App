import 'package:flutter/material.dart';
import 'home_screen.dart';

class ExpansionItem {
  bool isExpanded;
  String? header;
  String? body;
  String? room;
  bool toggle;
  String? star;

  ExpansionItem({
    this.toggle = false,
    this.isExpanded = false,
    required this.header,
    required this.body,
    required this.room,
    this.star,
  });
}

class Rooms extends StatefulWidget {
  final DateTime checkInDateTime;
  final DateTime checkOutDateTime;
  final double childrenRating;
  final double adultRating;
  final List<String> extrasCheckedItems;
  final String? selectedView;

  Rooms(
      {super.key,
      required this.checkInDateTime,
      required this.extrasCheckedItems,
      required this.checkOutDateTime,
      required this.childrenRating,
      required this.adultRating,
      this.selectedView});

  @override
  State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  late List<String> toggledRooms = [];
  final List<ExpansionItem> items = [
    ExpansionItem(
        header: 'Single Room',
        body: 'A room assigned to one person.',
        room:
            'https://img.freepik.com/free-photo/modern-studio-apartment-design-with-bedroom-living-space_1262-12375.jpg?w=996&t=st=1663761985~exp=1663762585~hmac=c20b072498ede48f0e3227b79ab9abc563ff3a91523bba949aebdfa4b296e2b3',
        star:
            'https://cdn-icons-png.flaticon.com/512/991/991985.png?w=740&t=st=1663767092~exp=1663767692~hmac=bce592b92150330e4ff006cf96879219a96bff0bcbfd3d688ddae855b58dc88f'),
    ExpansionItem(
        header: 'Double Room',
        body: 'A room assigned to two people. May have ine or more beds.',
        room:
            'https://img.freepik.com/free-photo/little-girl-alone-apartment_493343-25117.jpg?w=996&t=st=1663762023~exp=1663762623~hmac=983c84653559e95a8001bff1a8d1409e2e9fd6bf7ef48f4991a3694092e4ebcc',
        star:
            'https://cdn-icons-png.flaticon.com/512/991/991985.png?w=740&t=st=1663767092~exp=1663767692~hmac=bce592b92150330e4ff006cf96879219a96bff0bcbfd3d688ddae855b58dc88f'),
    ExpansionItem(
      header: 'Suite Room',
      body: 'A room with one or more bedrooms and separate living space.',
      room:
          'https://img.freepik.com/free-photo/luxury-bedroom-suite-resort-high-rise-hotel-with-working-table_105762-1783.jpg?w=900&t=st=1663761971~exp=1663762571~hmac=c5835f47d996ff643707eb19038879301f73f60b43d2f854d18af232e4c675c5',
      star:
          'https://cdn-icons-png.flaticon.com/512/991/991986.png?w=740&t=st=1663767093~exp=1663767693~hmac=0ac089c3dea5c8f7b082034314da7895f2d6f5637c73508d899c59783fa9cc83',
    ),
  ];

  showAlertDialog(context) {
    var alertDial = AlertDialog(
      title: const Text(
        'Are you sure you want to proceed in checking out?',
      ),
      content: Text(
        '''
This is an confirmation that you are agree on all data you entered:\n
Check-in Date: ${widget.checkInDateTime.year} / ${widget.checkInDateTime.month} / ${widget.checkInDateTime.day}
Check-out Date: ${widget.checkOutDateTime.year} / ${widget.checkOutDateTime.month} / ${widget.checkOutDateTime.day}
Number of Adults: ${widget.adultRating}
Number of Children: ${widget.childrenRating}
Extras: ${widget.extrasCheckedItems.join(" - ")}
View: ${widget.selectedView}
Chosen Rooms: ${toggledRooms.join(" - ")}
          ''',
        style: const TextStyle(
            fontWeight: FontWeight.w500, height: 1.4, fontSize: 16),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Your CheckOut has been successfully submitted',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16)),
                duration: Duration(seconds: 3),
              ));
            },
            child: const Text(
              'Confirm',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            )),
        ElevatedButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false);
          },
          child: const Text(
            'Discard',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
      ],
    );
    showDialog(context: context, builder: (context) => alertDial);
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
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                ExpansionPanelList(
                    expansionCallback: (index, isExpanded) {
                      setState(() {
                        items[index].isExpanded = !isExpanded;
                      });
                    },
                    children: items.map<ExpansionPanel>((ExpansionItem item) {
                      return ExpansionPanel(
                          headerBuilder: (context, isExpanded) {
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: ListTile(
                                leading: Image(
                                  image: NetworkImage(item.room!),
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                                title: Row(
                                  children: [
                                    Text('${item.header}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w700,
                                        )),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Expanded(
                                      child: Switch(
                                        value: item.toggle,
                                        onChanged: (bool newToggle) {
                                          setState(() {
                                            item.toggle = newToggle;
                                            if (item.toggle == true) {
                                              toggledRooms.add(item.header!);
                                            } else {
                                              toggledRooms.removeLast();
                                            }
                                            print(item.toggle);
                                            print(toggledRooms.toString());
                                          });
                                        },
                                        activeColor: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          body: Container(
                            padding: const EdgeInsets.only(bottom: 6, left: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 30,
                                  child: Image(
                                    image: NetworkImage('${item.star}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Text('${item.body}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.lightBlue,
                                          fontWeight: FontWeight.w400,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          isExpanded: item.isExpanded);
                    }).toList()),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      onPressed: () {
                        showAlertDialog(context);
                      },
                      color: Colors.lightBlueAccent,
                      child: const Text('Book Now!',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
