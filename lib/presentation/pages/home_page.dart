import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/data/models/university.dart';
import 'package:test/presentation/bloc/home_bloc.dart';
import 'package:test/presentation/bloc/home_event.dart';
import 'package:test/presentation/bloc/home_state.dart';
import 'package:test/presentation/pages/university_detail.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(const OnLoad());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Watch Now',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: BlocBuilder<HomeBloc, UniversitiesState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HomeHasDataAsGrid) {
              return Column(
                children: [
                  Expanded(
                    child: GridView.count(
                      key: const Key('movie-gridview'),
                      crossAxisCount: 2,
                      children: List.generate(state.result.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            // _navigateToDetail(context, state.result[index]);
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            color: Colors.grey[850],
                            child: Center(
                              child: Column(
                                children: [
                                  Image.network(
                                    'https://user-images.githubusercontent.com/61885011/132903284-a8e9f688-39ad-487c-9bc4-6f1404c469bc.png',
                                    fit: BoxFit.cover,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Example title", //state.result[index].name,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "(2004)", //state.result[index].name,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Stars", //state.result[index].name,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "lorem ipsum .. description", //state.result[index].name,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              );
            } else if (state is HomeError) {
              return const Center(
                child: Text('Something went wrong!'),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, University university) {
    Navigator.pushNamed(
      context,
      UniversityDetail.routeName,
      arguments: UniversityDetailArguments(university),
    );
  }
}
