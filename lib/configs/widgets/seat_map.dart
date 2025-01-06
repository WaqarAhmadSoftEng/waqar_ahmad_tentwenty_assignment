import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../images/image_urls.dart';

class SeatsMap extends StatefulWidget {
  final List<int> seatsPerRow;

  const SeatsMap({Key? key, required this.seatsPerRow}) : super(key: key);

  @override
  _SeatsMapState createState() => _SeatsMapState();
}

class _SeatsMapState extends State<SeatsMap> {
  List<List<bool>> _selectedSeats = [];

  @override
  void initState() {
    super.initState();
    _selectedSeats = List.generate(
        15, (index) => List.filled(widget.seatsPerRow[index], false));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(15, (rowIndex) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(widget.seatsPerRow[rowIndex], (seatIndex) {
            if (rowIndex == 14 && (seatIndex == 0 || seatIndex == 3)) {
              return const SizedBox(height: 10, width: 10);
            }
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedSeats[rowIndex][seatIndex] =
                  !_selectedSeats[rowIndex][seatIndex];
                });
              },
              child: SvgPicture.asset(
                ImageUrls.darkPinkSeat,
                color: _selectedSeats[rowIndex][seatIndex]
              ? Colors.red
                : Colors.blue,
                height: 10,
                width: 10,
              ),
            );
          }),
        );
      }),
    );
  }
}