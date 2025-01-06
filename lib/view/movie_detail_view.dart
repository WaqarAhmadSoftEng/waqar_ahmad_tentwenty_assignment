import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/movie_detail/movie_detail_bloc.dart';
import '../bloc/movie_detail/movie_detail_event.dart';
import '../bloc/movie_detail/movie_detail_state.dart';
import '../configs/color/app_colors.dart';
import '../configs/route/routes/routes_name.dart';
import '../configs/widgets/back_button.dart';
import '../repo/movies_repository.dart';
import 'movie_trailer_view.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
    late MovieDetailBloc _movieDetailBloc;

  @override
  void initState() {
    super.initState();
    _movieDetailBloc = MovieDetailBloc(MovieRepository());
    _movieDetailBloc.add(FetchMovieDetails(widget.movieId));
  }
  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return BlocProvider(
      create: (context) => MovieDetailBloc(MovieRepository())
        ..add(FetchMovieDetails(widget.movieId))
        ..add(FetchMovieTrailers(widget.movieId)),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<MovieDetailBloc, MovieDetailState>(
                bloc: _movieDetailBloc,
                builder: (context, state) {
                  if (state is MovieDetailInitial || state is MovieDetailLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MovieDetailLoaded) {
                    final movieDetail = state.movieDetail;
                    final trailer = state.trailers;
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: isPortrait? 475.h : 500.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage('https://image.tmdb.org/t/p/w500${movieDetail.posterPath}'),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 13.0, top: 50.h, bottom: 50.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const CustomBackButton(iconColor: Colors.white),
                                      SizedBox(width: 10.w),
                                      Text(
                                        'Watch',
                                        style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Center(
                                    child: Text(
                                        movieDetail.title,
                                      style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, RoutesName.seatMapView);
                                    },
                                    child: Center(
                                      child: Container(
                                        width: 243.w,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.r),
                                          color: Colors.blue,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Get Tickets',
                                            style: TextStyle(fontSize: 14.sp, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> TrailerPlayerScreen(
                                        videoKey: trailer.first.key,
                                      )));
                                    },
                                    child: Center(
                                      child: Container(
                                        width: 243.w,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.r),
                                          border: Border.all(color: Colors.blue, width: 2.w),
                                          color: Colors.transparent,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Watch Trailer',
                                            style: TextStyle(fontSize: 14.sp, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Genres', style: TextStyle(fontSize: 16.sp, color: AppColors.black)),
                                SizedBox(height: 8.h),
                                Row(
                                  children: [
                                    _buildGenreChip(
                                      'Action',
                                      AppColors.lightGreen,
                                    ),
                                    SizedBox(width: 8.w),
                                    _buildGenreChip(
                                      'Thriller',
                                      AppColors.pink,
                                    ),
                                    SizedBox(width: 8.w),
                                    _buildGenreChip(
                                      'Science',
                                      AppColors.navyBlue,
                                    ),
                                    SizedBox(width: 8.w),
                                    _buildGenreChip(
                                      'Fiction',
                                      AppColors.yellow,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                Text('Overview', style: TextStyle(fontSize: 16.sp, color: AppColors.black),),
                                SizedBox(height: 16.h),
                                Text(
                                  movieDetail.overview,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF8F8F8F),
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is MovieDetailError) {
                    return Center(
                      child: Text(
                        'Error: ${state.errorMessage}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
    Widget _buildGenreChip(String text, Color backgroundColor) {
      return Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
          child: Text(
            text,
            style: TextStyle(fontSize: 12.sp, color: Colors.white),
          ),
        ),
      );
    }
}