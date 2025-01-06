import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/movie_list/movie_list_bloc.dart';
import '../../bloc/movie_list/movie_list_event.dart';
import '../../bloc/search/search_bloc.dart';
import '../../bloc/search/search_event.dart';
import '../../bloc/search/search_state.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearch;

  const SearchBarWidget({
    super.key,
    required this.searchController,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBarBloc, SearchBarState>(
      builder: (context, state) {
        return TextFormField(
          controller: searchController,
          onChanged: onSearch,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFEFEFEF),
            hintText: 'Search TV shows, movies, and more...',
            hintStyle: TextStyle(color: const Color(0xFF202C43), fontSize: 14.sp),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                searchController.clear();
                BlocProvider.of<MovieListBloc>(context).add(FetchUpcomingMovies());
                BlocProvider.of<SearchBarBloc>(context).add(ToggleSearch());
              },
              icon: Icon(Icons.close, size: 18.sp),
            ),
            prefixIcon: const Icon(Icons.search),
          ),
        );
      },
    );
  }
}