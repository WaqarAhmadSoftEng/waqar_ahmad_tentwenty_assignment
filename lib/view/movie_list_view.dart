import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/movie_list/movie_list_bloc.dart';
import '../bloc/movie_list/movie_list_event.dart';
import '../bloc/movie_list/movie_list_state.dart';
import '../configs/color/app_colors.dart';
import '../configs/route/routes/routes_name.dart';
import '../configs/widgets/movie_cart.dart';
import '../repo/movies_repository.dart';

class WatchView extends StatefulWidget {
  const WatchView({super.key});

  @override
  State<WatchView> createState() => _WatchViewState();
}

class _WatchViewState extends State<WatchView> {
  final _movieBloc = MovieListBloc(MovieRepository());

  @override
  void initState() {
    super.initState();
    _movieBloc.add(FetchUpcomingMovies());
  }

  @override
  void dispose() {
    _movieBloc.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    double fontSize = isPortrait ? 16.sp : 10.sp;
    double paddingTop = isPortrait ? 10.h : 0.h;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.only(top: paddingTop),
        child: Column(
          children: [
            AppBar(
              backgroundColor: AppColors.white,
              title: Text(
                'Watch',
                style: TextStyle(fontSize: fontSize, color: AppColors.black),
              ),
              actions: [
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.movieSearchView);
                    },
                    child: const Icon(Icons.search)),
                SizedBox(
                  width: 10.w,
                )
              ],
              elevation: 0,
            ),
            Divider(
              height: 1.h,
              thickness: 1,
            ),
            Expanded(
              child: Container(
                color: Colors.grey.shade200,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 20.w, right: 20.w,  top: isPortrait? 20.h: 30.h, bottom: 80.h),
                  child: Center(
                    child: BlocProvider(
                      create: (context) => _movieBloc,
                      child: BlocBuilder<MovieListBloc, WatchState>(
                        builder: (context, state) {
                          if (state is WatchLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is WatchLoaded) {
                            final movies = state.upcomingMovies;
                            return ListView.separated(
                              itemCount: movies.length,
                              itemBuilder: (context, index) {
                                final movie = movies[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RoutesName.movieDetailView,
                                      arguments: movie.id,
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      MovieCart(
                                          moviePic: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                          movieName:  movie.title ?? ''),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 20.h);
                              },
                            );
                          } else if (state is WatchError) {
                            return Center(
                              child: Text('Error: ${state.error}'),
                            );
                          } else {
                            return const Text('Something went wrong!');
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}