import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:workout_tracking/screens/calender_screen.dart';

class CalenderWidget extends StatefulWidget {
  const CalenderWidget({
    super.key,
  });

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    List date = List.generate(
      7,
      (index) {
        return today.add(Duration(days: index - 3));
      },
    );
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CalenderScreen(),),);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: Row(
            children: date.map((day) {
              String dayOfWeek = DateFormat('dd').format(day);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  dayOfWeek,
                  style: GoogleFonts.roboto(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              );
            }).toList(), // Directly assign the list from map
          ),
        ),
      ),
    );
  }
}
