

import 'package:bloc_clean_coding/config/app_url.dart';
import 'package:bloc_clean_coding/data/network/network_api_services.dart';
import 'package:bloc_clean_coding/model/movies/movies.dart';
import 'package:bloc_clean_coding/repository/movies/movies_repository.dart';

class MoviesHttpApiRepository implements MoviesRepository {

  final _apiService = NetworkApiService();

  @override
  Future<MoviesModel> fetchMoviesList() async{
    final response = await _apiService.getApi(AppUrl.popularMoviesListEndPoint);
    return MoviesModel.fromJson(response);
  }

}