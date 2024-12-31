import 'package:bloc_clean_coding/bloc/movies_bloc/movies_bloc.dart';
import 'package:bloc_clean_coding/config/components/internet_exception_widget.dart';
import 'package:bloc_clean_coding/config/routes/routes_name.dart';
import 'package:bloc_clean_coding/main.dart';
import 'package:bloc_clean_coding/services/storage/local_stroage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/response/status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late MoviesBloc moviesBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moviesBloc = MoviesBloc(moviesRepository: getIt());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(onPressed: () {
            LocalStorage localStorage = LocalStorage();
            localStorage.clearValue('token').then((value) {
              Navigator.pushNamed(context, RoutesName.loginScreen);
            });
          }, icon: const Icon(Icons.logout))
        ],
      ),
      body: BlocProvider(
        create: (_) => moviesBloc..add(MoviesFetched()),
        child: BlocBuilder<MoviesBloc, MoviesState>(
          buildWhen: (previous, current) => previous.moviesList != current.moviesList,
          builder: (BuildContext context, state) {
            switch (state.moviesList.status) {
              case Status.loading:
                return const Center(child: CircularProgressIndicator());
              case Status.error:
                if (state.moviesList.message == '') {
                  return InterNetExceptionWidget(onPress: (){
                    moviesBloc.add(MoviesFetched());
                  });
                }
                return Center(child: Text(state.moviesList.message.toString()),); // Widget for displaying error state
              case Status.completed:
                if (state.moviesList.data == null) {
                  return const Text('No Data Found');
                }
                final movieList = state.moviesList.data!;

                return ListView.builder(
                    itemCount: movieList.tvShows.length,
                    itemBuilder: (context, index) {
                      final tvShow = movieList.tvShows[index];
                      return Card(
                        child: ListTile(
                          title: Text(tvShow.name.toString()),
                          subtitle: Text(tvShow.network.toString()),
                          trailing: Text(tvShow.status.toString()),
                        ),
                      );
                    });
              default:
                return const SizedBox();
            }
          },
        ),

      ),
    );
  }
}
