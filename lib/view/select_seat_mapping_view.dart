import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../bloc/seat_mapping/date_bloc.dart';
import '../bloc/seat_mapping/date_state.dart';
import '../bloc/seat_mapping/select_hall_bloc.dart';
import '../bloc/seat_mapping/select_hall_state.dart';
import '../bloc/seat_mapping/select_seat_bloc.dart';
import '../bloc/seat_mapping/select_seat_event.dart';
import '../bloc/seat_mapping/select_seat_state.dart';
import '../configs/color/app_colors.dart';
import '../configs/images/image_urls.dart';
import '../configs/widgets/back_button.dart';
import '../configs/widgets/seat_layout.dart';

class SelectSeatMapView extends StatefulWidget {
  const SelectSeatMapView({super.key});

  @override
  _SelectSeatMapViewState createState() => _SelectSeatMapViewState();
}

class _SelectSeatMapViewState extends State<SelectSeatMapView> {
  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return BlocProvider(
      create: (_) => SeatSelectionBloc(),
      child: Scaffold(
          backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          leading: const CustomBackButton(iconColor: Colors.black),
          title: Column(
            children: [
              Text(
                'The King’s Man',
                style: TextStyle(fontSize: isPortrait? 16.sp: 10.sp),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<DateBloc, DateState>(
                    builder: (context, state) {
                      final date = state is DateSelected ? state.selectedDate : '';
                      return Center(
                        child: Text(
                          'March $date, 2021',
                          style: TextStyle(fontSize: isPortrait? 12.sp : 6.sp, color: AppColors.blue),
                        ),
                      );
                    },
                  ),
                  Center(
                    child: Text(
                      '  |  ',
                      style: TextStyle(fontSize: 10.sp, color: AppColors.blue),
                    ),
                  ),
                  BlocBuilder<HallBloc, HallState>(
                    builder: (context, state) {
                      final selectedHall = state is HallSelected ? state.selectedHall : '';
                      final time = state is HallSelected ? state.time : '';
                      return Center(
                        child: Text(
                          '$time ${selectedHall.split('+').last.trim()}',
                          style: TextStyle(fontSize: 12.sp, color: AppColors.blue),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: isPortrait? Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(height: 1.h),
              Expanded(
                child: Container(
                  color: Colors.grey.shade200,
                  child: Padding(
                    padding: EdgeInsets.only(top: 80.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<SeatSelectionBloc, SeatSelectionState>(
                          builder: (context, state) {
                            return Transform.scale(
                              scale: state.zoomLevel,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 146.64.h,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: List.generate(9, (index) => _lineOfSeat((index + 1).toString())),
                                    ),
                                  ),
                                  SizedBox(width: 20.w),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Stack(
                                        children: [
                                          SvgPicture.asset(ImageUrls.screenLine, width: 328.78.w),
                                          Positioned(
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            child: Center(
                                              child: Text(
                                                'Screen',
                                                style: TextStyle(fontSize: 8.sp, color: const Color(0xFF8F8F8F)),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 20.h),
                                      SizedBox(
                                        width: 328.78.w,
                                        height: 145.52.h,
                                        child: SeatGrid(
                                          onSeatSelected: (seat, row, price) {
                                            context.read<SeatSelectionBloc>().add(SelectSeat(seat: seat, row: row, price: price));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const Spacer(),
                        BlocBuilder<SeatSelectionBloc, SeatSelectionState>(
                          builder: (context, state) {
                            return Align(
                              alignment: Alignment.topRight,
                              child: SizedBox(
                                width: 64.27.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _zoomButton(
                                      onTap: () => context.read<SeatSelectionBloc>().add(ZoomIn()),
                                      icon: Icons.add,
                                    ),
                                    _zoomButton(
                                      onTap: () => context.read<SeatSelectionBloc>().add(ZoomOut()),
                                      icon: Icons.remove,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20.h),
                        Center(
                          child: Container(
                            height: 5.h,
                            width: 334.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.r),
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          height: 252.h,
                          color: Colors.white,
                          padding: EdgeInsets.all(20.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15.h),
                              _seatLegend(),
                              SizedBox(height: 25.h),
                              _seatSelectionInfo(),
                              SizedBox(height: 35.h),
                              _paymentRow(),
                            ],
                          ),
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
                Divider(height: 1.h),
                Container(
                  color: Colors.grey.shade200,
                  child: Padding(
                    padding: EdgeInsets.only(top: 80.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<SeatSelectionBloc, SeatSelectionState>(
                          builder: (context, state) {
                            return Transform.scale(
                              scale: state.zoomLevel,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 346.64.h,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: List.generate(9, (index) => _lineOfSeat((index + 1).toString())),
                                    ),
                                  ),
                                  SizedBox(width: 20.w),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Stack(
                                        children: [
                                          SvgPicture.asset(ImageUrls.screenLine, width: 328.78.w),
                                          Positioned(
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            child: Center(
                                              child: Text(
                                                'Screen',
                                                style: TextStyle(fontSize: 8.sp, color: const Color(0xFF8F8F8F)),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 20.h),
                                      SizedBox(
                                        width: 328.78.w,
                                        height: 345.52.h,
                                        child: SeatGrid(
                                          onSeatSelected: (seat, row, price) {
                                            context.read<SeatSelectionBloc>().add(SelectSeat(seat: seat, row: row, price: price));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        BlocBuilder<SeatSelectionBloc, SeatSelectionState>(
                          builder: (context, state) {
                            return Align(
                              alignment: Alignment.topRight,
                              child: SizedBox(
                                width: 30.27.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _zoomButton(
                                      onTap: () => context.read<SeatSelectionBloc>().add(ZoomIn()),
                                      icon: Icons.add,
                                    ),
                                    _zoomButton(
                                      onTap: () => context.read<SeatSelectionBloc>().add(ZoomOut()),
                                      icon: Icons.remove,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 30.h),
                        Center(
                          child: Container(
                            height: 10.h,
                            width: 334.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.r),
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Container(
                          height: 392.h,
                          color: Colors.white,
                          padding: EdgeInsets.all(20.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15.h),
                              _seatLegend(),
                              SizedBox(height: 25.h),
                              _seatSelectionInfo(),
                              SizedBox(height: 35.h),
                              _paymentRow(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
                        ),
                      ),
            )
      ),
    );
  }

  Widget _lineOfSeat(String number) {
    return Text(
      number,
      style: TextStyle(fontSize: 5.38.sp, fontWeight: FontWeight.bold),
    );
  }

  Widget _zoomButton({required VoidCallback onTap, required IconData icon}) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: isPortrait? 29.13.h : 50.h,
        width: isPortrait? 29.13.w : 50.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white,
          border: Border.all(color: const Color(0xFFEFEFEF), width: 2.0),
        ),
        child: Center(child: Icon(icon)),
      ),
    );
  }

  Widget _seatLegend() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return SizedBox(
      width: 260.65.w,
      height: isPortrait? 53.h: 83.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _seatLegendColumn([
            _legendRow(AppColors.yellow, 'Selected'),
            _legendRow(AppColors.navyBlue, 'VIP (150 \$)'),
          ]),
          _seatLegendColumn([
            _legendRow(const Color(0xFFA6A6A6), 'Not available'),
            _legendRow(AppColors.blue, 'Regular (50 \$)'),
          ]),
        ],
      ),
    );
  }

  Widget _seatLegendColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  Widget _legendRow(Color color, String text) {
      final isPortrait =
          MediaQuery.of(context).orientation == Orientation.portrait;
    return Row(
      children: [
        SvgPicture.asset(ImageUrls.pinkSeat, color: color, width: isPortrait? 17.01.w: 29.01.w, height: isPortrait? 16.16.h: 28.28.h),
        SizedBox(width: 10.w),
        Text(text, style: TextStyle(color:  const Color(0xFF8F8F8F), fontSize: isPortrait? 12.sp : 10.sp)),
      ],
    );
  }

  Widget _seatSelectionInfo() {
    return BlocBuilder<SeatSelectionBloc, SeatSelectionState>(
      builder: (context, state) {
        final isPortrait =
            MediaQuery.of(context).orientation == Orientation.portrait;
        return Container(
          width: 97.w,
          height: isPortrait? 30.h : 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: const Color(0xFFA6A6A6).withOpacity(0.1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.selectedSeat.isNotEmpty ? state.selectedSeat : '0', style: TextStyle(fontSize: isPortrait? 14.sp: 12.sp)),
              Text('/', style: TextStyle(fontSize: 10.sp)),
              Text(state.selectedRow.isNotEmpty ? state.selectedRow : '0', style: TextStyle(fontSize: 10.sp)),
              SizedBox(width: 5.w),
              SvgPicture.asset(ImageUrls.remove),
            ],
          ),
        );
      },
    );
  }

  Widget _paymentRow() {
    return BlocBuilder<SeatSelectionBloc, SeatSelectionState>(
      builder: (context, state) {
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _paymentContainer('Total Price', '\$ ${state.totalPrice.toStringAsFixed(2)}'),
              _paymentContainer('Proceed to pay', '', isActionButton: true),
            ],
          ),
        );
      },
    );
  }

  Widget _paymentContainer(String label, String amount, {bool isActionButton = false}) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      width: isActionButton ? 216.w : 108.w,
      height: isPortrait? 50.h: 70.h,
      decoration: BoxDecoration(
        color: isActionButton ? AppColors.blue : const Color(0xFFA6A6A6).withOpacity(0.1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Center(
        child: isActionButton
            ? Text(label, style: TextStyle(fontSize: 12.sp, color: Colors.white))
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: TextStyle(fontSize: isPortrait? 12.sp: 8.sp, color: AppColors.black)),
            Text(amount, style: TextStyle(fontSize: isPortrait? 12.sp: 8.sp, color: AppColors.black)),
          ],
        ),
      ),
    );
  }
}