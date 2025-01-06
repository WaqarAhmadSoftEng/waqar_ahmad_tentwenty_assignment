import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/movie_list/movie_list_bloc.dart';
import '../bloc/movie_list/movie_list_event.dart';
import '../bloc/movie_list/movie_list_state.dart';
import '../configs/color/app_colors.dart';
import '../configs/route/routes/routes_name.dart';
import '../configs/widgets/movie_cart.dart';
import '../configs/widgets/search_bar.dart';
import '../repo/movies_repository.dart';

class MovieSearchView extends StatefulWidget {
  const MovieSearchView({super.key});

  @override
  State<MovieSearchView> createState() => _MovieSearchViewState();
}

class _MovieSearchViewState extends State<MovieSearchView> {
  final _movieBloc = MovieListBloc(MovieRepository());
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _movieBloc.add(FetchUpcomingMovies());
  }

  @override
  void dispose() {
    _movieBloc.close();
    searchController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    if (query.isNotEmpty) {
      _movieBloc.add(SearchMovies(query));
    } else {
      _movieBloc.add(FetchUpcomingMovies());
    }
  }
  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    double paddingTop = isPortrait ? 10.h : 0.h;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: SearchBarWidget(
          searchController: searchController,
          onSearch: _onSearch,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: paddingTop),
        child: Column(
          children: [
            Divider(
              height: 1.h,
              thickness: 1,
            ),
            Expanded(
              child: Container(
                color: Colors.grey.shade200,
                child: BlocProvider(
                  create: (_) => _movieBloc,
                  child: BlocBuilder<MovieListBloc, WatchState>(
                    builder: (context, state) {
                      if (state is WatchLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is WatchLoaded) {
                        final movies = state.upcomingMovies;
                        if (movies.isEmpty) {
                          return const Center(child: Text('No movies found.'));
                        }
                        return Padding(
                            padding: EdgeInsets.only(
                                left: 20.w, right: 20.w,  top: isPortrait? 35.h: 30.h, bottom: 10.h),
                          child: ListView.separated(
                            itemCount: movies.length,
                            itemBuilder: (context, index) {
                              final movie = movies[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesName.movieDetailView,
                                    arguments: movie.id, // Pass the movieId
                                  );
                                },
                                child: MovieCart(
                                   moviePic:  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                   movieName:  movie.title ?? ''),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 20.h);
                            },
                          ),
                        );
                      } else if (state is WatchError) {
                        return Center(child: Text('Error: ${state.error}'));
                      } else {
                        return const Center(child: Text('Something went wrong!'));
                      }
                    },
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
