import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_app/CustomWidgets/search_input_field.dart';
import 'package:interview_app/Modules/Module_1_Home/bloc/trending_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController searchController = TextEditingController();

  bool isSearchBarEmpty = true;

  bool isDark = true;

  @override
  void initState() {
    super.initState();

    searchController.addListener(updateButtonState);
  }

  void updateButtonState() {
    setState(() {
      isSearchBarEmpty = searchController.text.trim().isEmpty;
    });
  }

  @override
  void dispose() {
    searchController.removeListener(updateButtonState);

    searchController.dispose();

    super.dispose();
  }

  void changeTheme() {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrendingBloc()
        ..add(
          FetchTrendingGifs(),
        ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: isDark ? Colors.black : Colors.white,
          body: Column(
            children: [
              // Search
              BlocBuilder<TrendingBloc, TrendingState>(
                builder: (context, state) {
                  return SearchInputField(
                    controller: searchController,
                    hint: "Search cats...",
                    isDark: isDark,
                    onTextChanged: (value) {
                      if (!isSearchBarEmpty) {
                        context.read<TrendingBloc>().add(
                              FetchSearchGifs(qruery: value),
                            );
                      } else {
                        context.read<TrendingBloc>().add(
                              FetchTrendingGifs(),
                            );
                      }
                    },
                  );
                },
              ),

              const SizedBox(
                height: 20.0,
              ),

              // Toggle
              Switch(
                value: isDark,
                onChanged: (value) {
                  changeTheme();
                },
              ),

              const SizedBox(
                height: 20.0,
              ),

              //  Data
              BlocBuilder<TrendingBloc, TrendingState>(
                builder: (context, state) {
                  if (state is FetchTrendingGifsLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is FetchTrendingGifsErrorState) {
                    return Text("No Data Found");
                  }
                  if (state is FetchTrendingGifsFetchedState) {
                    return Expanded(
                      child: GridView.builder(
                        itemCount: state.gifsResponseClass.gifUrls.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(
                            state.gifsResponseClass.gifUrls[index],
                          );
                        },
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
