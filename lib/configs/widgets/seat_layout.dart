import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../color/app_colors.dart';
class SeatGrid extends StatefulWidget {
  final Function(String selectedSeat, String row, double totalPrice) onSeatSelected;

  const SeatGrid({super.key, required this.onSeatSelected});

  @override
  _SeatGridState createState() => _SeatGridState();
}

class _SeatGridState extends State<SeatGrid> {
  int? _selectedGridIndex;
  int? _selectedRowIndex;
  int? _selectedSeatIndex;

  double _calculateTotalPrice(int gridIndex, int rowIndex, int seatIndex, List<int> vipSeats, List<int> regularSeats) {
    const double vipPrice = 150.0;
    const double regularPrice = 50.0;

    if (vipSeats.contains(seatIndex)) {
      return vipPrice;
    }

    if (regularSeats.contains(seatIndex)) {
      return regularPrice;
    }
    return 0.0;
  }

  void _onSeatTapped(int gridIndex, int rowIndex, int seatIndex, List<int> vipSeats, List<int> regularSeats) {
    setState(() {
      _selectedGridIndex = gridIndex;
      _selectedRowIndex = rowIndex;
      _selectedSeatIndex = seatIndex;
    });

    String selectedSeat = '${seatIndex + 1}';
    String selectedRow = '${rowIndex + 1}';
    double totalPrice = _calculateTotalPrice(gridIndex, rowIndex, seatIndex, vipSeats, regularSeats);

    widget.onSeatSelected(selectedSeat, selectedRow, totalPrice);
  }

  Widget generateRow({
    required int seatCount,
    List<int>? unavailableSeats,
    List<int>? vipSeats,
    List<int>? regularSeats,
    required int gridIndex,
    required int rowIndex,
  }) {
    return Row(
      children: List.generate(seatCount, (seatIndex) {
        bool isUnavailable = unavailableSeats?.contains(seatIndex) ?? false;
        bool isVip = vipSeats?.contains(seatIndex) ?? false;
        bool isRegular = regularSeats?.contains(seatIndex) ?? false;

        bool isSelected = _selectedGridIndex == gridIndex &&
            _selectedRowIndex == rowIndex &&
            _selectedSeatIndex == seatIndex;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Column(
            children: [
              GestureDetector(
                onTap: isUnavailable
                    ? null
                    : () {
                  _onSeatTapped(gridIndex, rowIndex, seatIndex, vipSeats ?? [], regularSeats ?? []);
                },
                child: Container(
                  width: 6.98.w,
                  height: 6.0.h,
                  decoration: BoxDecoration(
                    color: isUnavailable
                        ? AppColors.grey
                        : isSelected
                        ? AppColors.yellow
                        : isVip
                        ? AppColors.navyBlue
                        : isRegular
                        ? AppColors.blue
                        : AppColors.white,
                    borderRadius: BorderRadius.circular(1.r),
                  ),
                ),
              ),
              SizedBox(height: 1.h),
              Container(
                width: 6.w,
                height: 2.h,
                decoration: BoxDecoration(
                  color: isUnavailable
                      ? AppColors.grey
                      : isSelected
                      ? AppColors.yellow
                      : isVip
                      ? AppColors.navyBlue
                      : isRegular
                      ? AppColors.blue
                      : AppColors.white,
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 328.28.w,
      height: 145.52.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildGridColumn(
            gridIndex: 0,
            rows: [
              [2, [0, 1], [], [], 0],
              [4, [1, 3], [], [0, 2], 1],
              [4, [0, 2, 3], [], [1], 2],
              [4, [0, 1, 3], [], [2], 3],
              [5, [2, 3, 4], [], [0, 1], 4],
              [5, [0, 1, 4], [], [2, 3], 5],
              [5, [2, 3, 4], [], [0, 1], 6],
              [5, [0, 1, 4], [], [2, 3], 7],
              [5, [2, 3, 4], [], [0, 1], 8],
              [5, [], [0, 1, 2, 3, 4], [], 9],
            ],
          ),
          _buildGridColumn(
            gridIndex: 1,
            rows: [
              [14, [2, 3, 6, 7, 10, 11], [], [0, 1, 4, 5, 8, 9, 12, 13], 0],
              [14, [0, 1, 4, 5, 8, 9, 12, 13], [], [2, 3, 6, 7, 10, 11], 1],
              [14, [2, 3, 6, 7, 10, 11], [], [0, 1, 4, 5, 8, 9, 12, 13], 2],
              [14, [0, 1, 4, 5, 8, 9, 12, 13], [], [2, 3, 6, 7, 10, 11], 3],
              [14, [2, 3, 6, 7, 10, 11], [], [0, 1, 4, 5, 8, 9, 12, 13], 4],
              [14, [0, 1, 4, 5, 8, 9, 12, 13], [], [2, 3, 6, 7, 10, 11], 5],
              [14, [2, 3, 6, 7, 10, 11], [], [0, 1, 4, 5, 8, 9, 12, 13], 6],
              [14, [0, 1, 4, 5, 8, 9, 12, 13], [], [2, 3, 6, 7, 10, 11], 7],
              [14, [2, 3, 6, 7, 10, 11], [], [0, 1, 4, 5, 8, 9, 12, 13], 8],
              [14, [4], [0, 1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13], [], 9],
            ],
          ),
          _buildGridColumn(
            gridIndex: 3,
            rows: [
              [2, [0, 1], [], [], 0],
              [4, [0, 2], [], [1, 3], 1],
              [4, [0, 1, 3], [], [2], 2],
              [4, [0, 2, 3], [], [1], 3],
              [5, [0, 1, 2], [], [3, 4], 4],
              [5, [0, 3, 4], [], [1, 2], 5],
              [5, [0, 1, 2], [], [3, 4], 6],
              [5, [0, 3, 4], [], [1, 2], 7],
              [5, [0, 1, 2], [], [3, 4], 8],
              [5, [], [0, 1, 2, 3, 4], [], 9],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGridColumn({
    required int gridIndex,
    required List<List<dynamic>> rows,
  }) {
    CrossAxisAlignment crossAxisAlignment =
    gridIndex == 3 ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    return SizedBox(
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(rows.length, (index) {
          final unavailableSeats = _toIntList(rows[index][1]);
          final vipSeats = _toIntList(rows[index][2]);
          final regularSeats = _toIntList(rows[index][3]);

          return generateRow(
            seatCount: rows[index][0] as int,
            unavailableSeats: unavailableSeats,
            vipSeats: vipSeats,
            regularSeats: regularSeats,
            gridIndex: gridIndex,
            rowIndex: rows[index][4] as int,
          );
        }),
      ),
    );
  }

  List<int> _toIntList(dynamic data) {
    if (data is List) {
      return data.cast<int>();
    }
    return [];
  }
}
