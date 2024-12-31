

import 'package:freezed_annotation/freezed_annotation.dart';
part 'movies.freezed.dart';
part 'movies.g.dart';

@freezed
class MoviesModel with _$MoviesModel {

  factory MoviesModel({
    @Default(0) @JsonKey(name: 'total')int total,
    @Default(0) int page,
    @Default(0) int pages,
    @Default([]) @JsonKey(name: 'tv_shows') List<TvShows>tvShows}) = _MoviesModel;

  factory MoviesModel.fromJson(Map<String, dynamic> json) =>
      _$MoviesModelFromJson(json);
}


@freezed
class TvShows with _$TvShows {
  factory TvShows({
    @JsonKey(name: 'name') @Default('') String name,
    @Default('') String permalink,
    @Default('') String endDate,
    @Default('') String network,
    @Default('') String imageThumbnailPath,
    @Default('') String status,
  }) = _TvShows; // Constructor for the freezed class


  factory TvShows.fromJson(Map<String, dynamic> json) =>
      _$TvShowsFromJson(json);
}