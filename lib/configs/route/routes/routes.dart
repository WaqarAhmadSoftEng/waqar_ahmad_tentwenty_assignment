import 'package:flutter/material.dart';
import 'package:tentwenty_assignment/configs/route/routes/routes_name.dart';
import '../../../view/movie_detail_view.dart';
import '../../../view/movie_list_view.dart';
import '../../../view/movie_search_view.dart';
import '../../../view/nav_bar_view.dart';
import '../../../view/seat_map_view.dart';
import '../../../view/select_seat_mapping_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case RoutesName.movieListView:
        return MaterialPageRoute(builder: (BuildContext context) => WatchView());

      case RoutesName.movieSearchView:
        return MaterialPageRoute(builder: (BuildContext context) => MovieSearchView());

      case RoutesName.navBarView:
        return MaterialPageRoute(builder: (BuildContext context) => const NavBarView());

      case RoutesName.selectSeatMapView:
        return MaterialPageRoute(builder: (BuildContext context) => SelectSeatMapView());

      case RoutesName.seatMapView:
        return MaterialPageRoute(builder: (BuildContext context) => const SeatMapView());

      case RoutesName.movieDetailView:
        final movieId = settings.arguments as int;
        return MaterialPageRoute(builder: (BuildContext context) => MovieDetailScreen(movieId: movieId),
        );

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}