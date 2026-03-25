import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_project/Features/home/presentation/bloc/home_bloc.dart';
import 'package:movies_app_project/Features/home/presentation/bloc/home_event.dart';
import 'package:movies_app_project/Features/home/presentation/bloc/home_state.dart';
import 'package:movies_app_project/Features/home/presentation/widgets/custom_empty_list_widget.dart'; // ملف الـ Lottie الجديد
import 'package:movies_app_project/Features/home/presentation/widgets/custom_movie_card.dart'; // الكارت الموحد
import 'package:movies_app_project/core/l10n/app_localizations.dart';

import 'package:movies_app_project/core/utils/router/pages_routes_name.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';
import 'package:movies_app_project/core/widgets/custom_text_form_field_widget.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: CustomEmptyListWidget(),
        ),
        /*
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
              child: CustomTextFormFieldWidget(
                text: appLocalizations.search,
                controller: _searchController,
                customPrefixWidget: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onFieldSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    context.read<HomeBloc>().add(
                      FetchSearchMovies(value.trim()),
                    );
                  }
                },
              ),
            ),


            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(

                buildWhen: (previous, current) =>
                    previous.searchState != current.searchState,
                builder: (context, state) {
                  final searchState = state.searchState;

                  if (searchState is SearchMoviesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  } else if (searchState is SearchMoviesError) {
                    return Center(
                      child: Text(
                        searchState.message,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  } else if (searchState is SearchMoviesSuccess) {
                    final movies = searchState.movies;

                    if (movies.isEmpty) return const CustomEmptyListWidget();

                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.7,
                          ),
                      itemCount: movies.length,
                      itemBuilder: (context, index) => CustomMovieCard(
                        movie: movies[index],
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            PagesRoutesName.movieDetailsView,
                            arguments: movies[index]
                                .id,
                          );
                        },
                      ),
                    );
                  }
                  return const CustomEmptyListWidget();
                },
              ),
            ),
          ],
        ),

         */
      ),
    );
  }
}
