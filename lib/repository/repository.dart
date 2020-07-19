import 'package:dio/dio.dart';
import 'package:moviedbapp/model/movie_response.dart';
import 'package:moviedbapp/model/genre_response.dart';
import 'package:moviedbapp/model/PersonResponse.dart';
import 'package:moviedbapp/model/movie_detail_response.dart';
import 'package:moviedbapp/model/cast_response.dart';
import 'package:moviedbapp/model/video_response.dart';

class MovieRepository {
    final String apiKey = "4b8c5be3d22f6e4ece12b0cd111047d0";
    static String mainUrl = "https://api.themoviedb.org/3";
    final Dio _dio = Dio();
    var getPopularUrl = '$mainUrl/movie/top_rated';
    var getMoviesUrl = '$mainUrl/discover/movie';
    var getPlayingUrl = '$mainUrl/movie/now_playing';
    var getGenresUrl = '$mainUrl/genre/movie/list';
    var getPersonsUrl = '$mainUrl/trending/person/week';
    var movieUrl = '$mainUrl/movie';

    Future<MovieResponse> getMovies() async {
      var params = {
        "api_key": apiKey,
        "language": "en-US",
          "page": 1
      };
      try {
        Response response = await _dio.get(getPopularUrl, queryParameters: params);
        return MovieResponse.fromJson(response.data);
      } catch (error , stacktrace) {
        print("Exception occurred: $error stackTrace: $stacktrace");
        return MovieResponse.withError("$error");
      }
    }

    Future<MovieResponse> getPlayingMovies() async {
      var params = {
        "api_key": apiKey,
        "language": "en-US",
        "page": 1
      };
      try {
        Response response = await _dio.get(getPlayingUrl, queryParameters: params);
        return MovieResponse.fromJson(response.data);
      } catch (error , stacktrace) {
        print("Exception occurred: $error stackTrace: $stacktrace");
        return MovieResponse.withError("$error");
      }
    }

    Future<GenreResponse> getGenres() async {
      var params = {
        "api_key": apiKey,
        "language": "en-US",
        "page": 1
      };
      try {
        Response response = await _dio.get(getGenresUrl, queryParameters: params);
        return GenreResponse.fromJson(response.data);
      } catch (error , stacktrace) {
        print("Exception occurred: $error stackTrace: $stacktrace");
        return GenreResponse.withError("$error");
      }
    }

    Future<PersonResponse> getPersons() async {
      var params = {
        "api_key": apiKey
      };
      try {
        Response response = await _dio.get(getPersonsUrl, queryParameters: params);
        return PersonResponse.fromJson(response.data);
      } catch (error , stacktrace) {
        print("Exception occurred: $error stackTrace: $stacktrace");
        return PersonResponse.withError("$error");
      }
    }

    Future<MovieResponse> getMovieByGenre(int id) async {
      var params = {
        "api_key": apiKey,
        "language": "en-US",
        "page": 1,
        "with_genres": id,
      };
      try {
        Response response = await _dio.get(getMoviesUrl, queryParameters: params);
        return MovieResponse.fromJson(response.data);
      } catch (error , stacktrace) {
        print("Exception occurred: $error stackTrace: $stacktrace");
        return MovieResponse.withError("$error");
      }
    }

    Future<MovieDetailResponse> getMovieDetail(int id) async {
      var params = {
        "api_key": apiKey,
        "language":"en-US"
      };
      try {
        Response response = await _dio.get(movieUrl + "/$id", queryParameters: params);
        return MovieDetailResponse.fromJson(response.data);
      } catch (error , stacktrace) {
        print("Exception occurred: $error stackTrace: $stacktrace");
        return MovieDetailResponse.withError("$error");
      }
    }

    Future<CastResponse> getCasts(int id) async {
      var params = {
        "api_key": apiKey,
        "language":"en-US"
      };
      try {
        Response response = await _dio.get(movieUrl + "/$id" + "/credits", queryParameters: params);
        return CastResponse.fromJson(response.data);
      } catch (error , stacktrace) {
        print("Exception occurred: $error stackTrace: $stacktrace");
        return CastResponse.withError("$error");
      }
    }

    Future<MovieResponse> getSimilarMovies(int id) async {
      var params = {
        "api_key": apiKey,
        "language":"en-US"
      };
      try {
        Response response = await _dio.get(movieUrl + "/$id" + "/similar", queryParameters: params);
        return MovieResponse.fromJson(response.data);
      } catch (error , stacktrace) {
        print("Exception occurred: $error stackTrace: $stacktrace");
        return MovieResponse.withError("$error");
      }
    }

    Future<VideoResponse> getMovieVideos(int id) async {
      var params = {
        "api_key": apiKey,
        "language":"en-US"
      };
      try {
        Response response = await _dio.get(movieUrl + "/$id" + "/videos", queryParameters: params);
        return VideoResponse.fromJson(response.data);
      } catch (error , stacktrace) {
        print("Exception occurred: $error stackTrace: $stacktrace");
        return VideoResponse.withError("$error");
      }
    }
}