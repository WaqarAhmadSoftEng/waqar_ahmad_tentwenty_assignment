import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../bloc/seat_mapping/date_bloc.dart';
import '../bloc/seat_mapping/date_event.dart';
import '../bloc/seat_mapping/date_state.dart';
import '../bloc/seat_mapping/select_hall_bloc.dart';
import '../bloc/seat_mapping/select_hall_event.dart';
import '../bloc/seat_mapping/select_hall_state.dart';
import '../configs/color/app_colors.dart';
import '../configs/images/image_urls.dart';
import '../configs/route/routes/routes_name.dart';
import '../configs/widgets/back_button.dart';
import '../configs/widgets/map_seat.dart';

class SeatMapView extends StatelessWidget {
  const SeatMapView({super.key});

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: const CustomBackButton(iconColor: Colors.black),
        title: Column(
          children: [
            Text(
              'The King’s Man',
              style: TextStyle(fontSize: isPortrait ? 16.sp : 10.sp),
            ),
            Text(
              'In theaters December 22, 2021',
              style: TextStyle(
                  fontSize: isPortrait ? 12.sp : 6.sp, color: AppColors.blue),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: isPortrait
          ? Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    height: 1.h,
                    thickness: 1,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.grey.shade200,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 20.w,
                            right: 0.w,
                            top: isPortrait ? 35.h : 30.h,
                            bottom: 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 80.h,
                            ),
                            Text('Date',
                                style: TextStyle(
                                    fontSize: 16.sp, color: AppColors.black)),
                            SizedBox(
                              height: 10.h,
                            ),
                            BlocBuilder<DateBloc, DateState>(
                              builder: (context, state) {
                                final selectedDate = state is DateSelected
                                    ? state.selectedDate
                                    : 1;
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(30, (index) {
                                      final date = index + 1;
                                      return GestureDetector(
                                        onTap: () {
                                          context
                                              .read<DateBloc>()
                                              .add(SelectDateEvent(date));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 10.w),
                                          width: 67.w,
                                          height: 32.h,
                                          decoration: BoxDecoration(
                                            color: selectedDate == date
                                                ? AppColors.blue
                                                : const Color(0xFFA6A6A6),
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '$date March',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: selectedDate == date
                                                    ? AppColors.white
                                                    : AppColors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            BlocBuilder<HallBloc, HallState>(
                              builder: (context, state) {
                                final selectedHall = state is HallSelected
                                    ? state.selectedHall
                                    : 'Cinetech + hall 1';
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      _buildHallColumn(
                                          context,
                                          '12:30',
                                          'Cinetech + hall 1',
                                          selectedHall,
                                          '50',
                                          '2500'),
                                      SizedBox(width: 20.w),
                                      _buildHallColumn(
                                          context,
                                          '13:30',
                                          'Cinetech + hall 2',
                                          selectedHall,
                                          '60',
                                          '3000'),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 16.w),
                              child: Center(
                                  child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesName.selectSeatMapView,
                                  );
                                },
                                child: Container(
                                  width: 323.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.blue,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Select Seat',
                                      style: TextStyle(
                                          fontSize: 12.sp, color: Colors.white),
                                    ),
                                  ),
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      height: 1.h,
                      thickness: 1,
                    ),
                    Container(
                      color: Colors.grey.shade200,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 20.w,
                            right: 0.w,
                            top: isPortrait ? 35.h : 30.h,
                            bottom: 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 80.h,
                            ),
                            Text('Date',
                                style: TextStyle(
                                    fontSize: 12.sp, color: AppColors.black)),
                            SizedBox(
                              height: 10.h,
                            ),
                            BlocBuilder<DateBloc, DateState>(
                              builder: (context, state) {
                                final selectedDate = state is DateSelected
                                    ? state.selectedDate
                                    : 1;
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(30, (index) {
                                      final date = index + 1;
                                      return GestureDetector(
                                        onTap: () {
                                          context
                                              .read<DateBloc>()
                                              .add(SelectDateEvent(date));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 10.w),
                                          width: 60.w,
                                          height: 35.h,
                                          decoration: BoxDecoration(
                                            color: selectedDate == date
                                                ? AppColors.blue
                                                : const Color(0xFFA6A6A6),
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '$date March',
                                              style: TextStyle(
                                                fontSize: 8.sp,
                                                color: selectedDate == date
                                                    ? AppColors.white
                                                    : AppColors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            BlocBuilder<HallBloc, HallState>(
                              builder: (context, state) {
                                final selectedHall = state is HallSelected
                                    ? state.selectedHall
                                    : 'Cinetech + hall 1';
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      _buildHallColumn(
                                          context,
                                          '12:30',
                                          'Cinetech + hall 1',
                                          selectedHall,
                                          '50',
                                          '2500'),
                                      SizedBox(width: 20.w),
                                      _buildHallColumn(
                                          context,
                                          '13:30',
                                          'Cinetech + hall 2',
                                          selectedHall,
                                          '60',
                                          '3000'),
                                    ],
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 60.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 16.w),
                              child: Center(
                                  child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesName.selectSeatMapView,
                                  );
                                },
                                child: Container(
                                  width: 323.w,
                                  height: 70.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.blue,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Select Seat',
                                      style: TextStyle(
                                          fontSize: 12.sp, color: Colors.white),
                                    ),
                                  ),
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildHallColumn(
    BuildContext context,
    String time,
    String hallName,
    String selectedHall,
    String price,
    String bonus,
  ) {
    final isSelected = hallName == selectedHall;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return GestureDetector(
      onTap: () {
        context.read<HallBloc>().add(SelectHallEvent(
            hallName: hallName, time: time, price: price, bonus: bonus));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                time,
                style: TextStyle(fontSize: 12.sp, color: AppColors.black),
              ),
              SizedBox(width: 5.w),
              Text(
                hallName,
                style:
                    TextStyle(fontSize: 12.sp, color: const Color(0xFF8F8F8F)),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Container(
            height: isPortrait? 145.h: 265.h,
            width: 249.w,
            decoration: BoxDecoration(
              border:
                  Border.all(color: isSelected ? AppColors.blue : Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: isPortrait? 110.0.h: 200.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      ImageUrls.screenLine,
                      width: 144.45.w,
                    ),
                    SizedBox(
                      height: isPortrait? 91.19.h: 120.h,
                      width: 144.45.w,
                      child: const SeatMap(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: isPortrait? 5.h: 20.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'From ',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF8F8F8F),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                TextSpan(
                  text: '$price ',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'or ',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF8F8F8F),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                TextSpan(
                  text: '$bonus bonus',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}