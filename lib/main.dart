import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tentwenty_assignment/repo/movies_repository.dart';
import 'bloc/movie_list/movie_list_bloc.dart';
import 'bloc/search/search_bloc.dart';
import 'bloc/seat_mapping/date_bloc.dart';
import 'bloc/seat_mapping/select_hall_bloc.dart';
import 'bloc/seat_mapping/select_seat_bloc.dart';
import 'configs/route/routes/routes.dart';
import 'configs/route/routes/routes_name.dart';

void main() {
  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SeatSelectionBloc()),
          BlocProvider(create: (context) => SearchBarBloc()),
          BlocProvider(create: (context) => DateBloc()),
          BlocProvider(create: (context) => HallBloc()),
          BlocProvider(create: (context) => MovieListBloc(MovieRepository())),
        ],
        child: const MyApp(),
      )
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_ , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TenTwenty',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            fontFamily: 'Poppins',
          ),
          initialRoute: RoutesName.navBarView,
          onGenerateRoute: Routes.generateRoute,
        );
      },
    );
  }
}