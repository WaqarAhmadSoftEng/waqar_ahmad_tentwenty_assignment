import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../images/image_urls.dart';

class SeatMap extends StatelessWidget {
  const SeatMap({super.key});

  @override
  Widget build(BuildContext context) {
    Widget generateRow(
        int seatCount, {
          List<int>? yellowIndices,
          List<int>? blueIndicator,
          List<int>? greyIndicator,
          List<int>? navyBlueIndicator,
        }) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          seatCount,
              (index) {
            final isGrey = greyIndicator?.contains(index) ?? false;
            final isBlue = blueIndicator?.contains(index) ?? false;
            final isNavyBlue = navyBlueIndicator?.contains(index) ?? false;
            final isYellow = yellowIndices?.contains(index) ?? false;

            final color = isGrey
                ? Colors.grey
                : isBlue
                ? Colors.blue
                : isNavyBlue
                ? Colors.indigo
                : isYellow
                ? Colors.yellow
                : Colors.grey;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.0.w),
              child: SvgPicture.asset(
                ImageUrls.darkPinkSeat,
                height: 2.92.h,
                width: 3.07.w,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              ),
            );
          },
        ),
      );
    }

    return SizedBox(
      height: 91.19.h,
      width: 144.45.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              generateRow(2, greyIndicator: [0, 1]),
              generateRow(4, blueIndicator: [0, 1, 2]),
              generateRow(4, navyBlueIndicator: [0, 3]),
              generateRow(4, navyBlueIndicator: [2]),
              generateRow(5, blueIndicator: [0, 1, 4]),
              generateRow(5),
              generateRow(5, blueIndicator: [0, 3, 4]),
              generateRow(5, blueIndicator: [0, 2, 3, 4]),
              generateRow(5, blueIndicator: [0, 1, 2, 3, 4]),
              generateRow(5, navyBlueIndicator: [0, 1, 2, 3, 4]),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              10, // Adjust the number as needed
                  (rowIndex) {
                if (rowIndex == 0) {
                  return generateRow(14, blueIndicator: [0, 1, 3, 5, 6, 7, 9, 11, 12, 13]);
                } else if (rowIndex == 1) {
                  return generateRow(14, blueIndicator: [1, 5, 6, 7, 9, 11, 12, 13]);
                } else if (rowIndex == 2) {
                  return generateRow(14, blueIndicator: [1, 3, 5, 6, 7,]);
                } else if (rowIndex == 3) {
                  return generateRow(14, blueIndicator: [5, 6]);
                } else if (rowIndex == 4) {
                  return generateRow(14, blueIndicator: [7, 8, 9]);
                } else if (rowIndex == 5) {
                  return generateRow(14, blueIndicator: [0, 1, 3, 5, 6, 7, 9, 11, 12, 13]);
                } else if (rowIndex == 6) {
                  return generateRow(14, blueIndicator: [11, 12, 13]);
                } else if (rowIndex == 7) {
                  return generateRow(14, blueIndicator: [0, 1 , 5, 6, 9, 11, 12, 13]);
                } else if (rowIndex == 8) {
                  return generateRow(14, blueIndicator: [15, 16]);
                } else if (rowIndex == 9) {
                  return generateRow(14, navyBlueIndicator: [0,1,2,3,5,6,7,8,9,10,11,12,13]);
                }
                return generateRow(14);
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              generateRow(2, greyIndicator: [0, 1]),
              generateRow(4, blueIndicator: [0, 1, 2]),
              generateRow(4, navyBlueIndicator: [0, 3]),
              generateRow(4, navyBlueIndicator: [2]),
              generateRow(5, blueIndicator: [0, 1, 4]),
              generateRow(5),
              generateRow(5, blueIndicator: [0, 3, 4]),
              generateRow(5, blueIndicator: [0, 2, 3, 4]),
              generateRow(5, blueIndicator: [0, 1, 2, 3, 4]),
              generateRow(5, navyBlueIndicator: [0, 1, 2, 3, 4]),
            ],
          ),
        ],
      ),
    );
  }
}
