import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../bloc/nav_bar/nav_bar_bloc.dart';
import '../bloc/nav_bar/nav_bar_event.dart';
import '../bloc/nav_bar/nav_bar_state.dart';
import '../configs/color/app_colors.dart';
import '../configs/images/image_urls.dart';
import 'movie_list_view.dart';

class NavBarView extends StatelessWidget {

  const NavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationBloc()
        ..add(
          ChangeScreenIndex(1),
        ),
      child: Scaffold(
        body: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            final screens = [
              const SizedBox.shrink(),
              const WatchView(),
              const SizedBox.shrink(),
              const SizedBox.shrink(),
            ];
            return screens[state.screenIndex];
          },
        ),
        extendBody: true,
        bottomNavigationBar: Builder(
          builder: (context) {
            return Container(
              height: 75.h,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: BlocBuilder<NavigationBloc, NavigationState>(
                builder: (context, state) {
                  return NavigationBar(
                    backgroundColor: AppColors.darkGrey,
                    selectedIndex: state.screenIndex,
                    destinations: [
                      _navBarItem(
                        context,
                        index: 0,
                        label: 'Dashboard',
                        icon: ImageUrls.dashboard,
                        isSelected: state.screenIndex == 0,
                      ),
                      _navBarItem(
                        context,
                        index: 1,
                        label: 'Watch',
                        icon: ImageUrls.watch,
                        isSelected: state.screenIndex == 1,
                      ),
                      _navBarItem(
                        context,
                        index: 2,
                        label: 'Media',
                        icon: ImageUrls.media,
                        isSelected: state.screenIndex == 2,
                      ),
                      _navBarItem(
                        context,
                        index: 3,
                        label: 'More',
                        icon: ImageUrls.more,
                        isSelected: state.screenIndex == 3,
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _navBarItem(
      BuildContext context, {
        required int index,
        required String label,
        required String icon,
        required bool isSelected,
      }) {

    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    double itemHeight = isPortrait ? 35.h : 45.h;
    double iconHeight = isPortrait ? 18.h : 19.h;
    double iconWeight = isPortrait ? 18.w : 19.w;
    double fontSize = isPortrait ? 10.sp : 6.sp;

    return InkWell(
      onTap: () {
        BlocProvider.of<NavigationBloc>(context).add(ChangeScreenIndex(index));
      },
      child: SizedBox(
        height: itemHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              icon,
              color: isSelected ? AppColors.white : AppColors.grey,
              height: iconHeight,
              width: iconWeight,
            ),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.white : AppColors.grey,
                fontSize: fontSize,
              ),
            )
          ],
        ),
      ),
    );
  }
}
