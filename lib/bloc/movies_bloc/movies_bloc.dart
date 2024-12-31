import 'package:bloc/bloc.dart';
import 'package:bloc_clean_coding/data/response/api_response.dart';
import 'package:bloc_clean_coding/model/movies/movies.dart';
import 'package:bloc_clean_coding/repository/movies/movies_repository.dart';
import 'package:equatable/equatable.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {

  MoviesRepository moviesRepository;
  MoviesBloc({required this.moviesRepository}) : super(MoviesState(moviesList: ApiResponse.loading())) {
    on<MoviesFetched>(fetchMoviesListApi);

  }


  Future<void> fetchMoviesListApi (MoviesFetched event, Emitter<MoviesState> emit) async {

    await moviesRepository.fetchMoviesList().then((response) {
      emit(state.copyWith(
        moviesList: ApiResponse.completed(response),
      ));
    }).onError((error, stackTrace) {
      emit(state.copyWith(
        moviesList: ApiResponse.error(error.toString()),
      ));
    });

  }
}
