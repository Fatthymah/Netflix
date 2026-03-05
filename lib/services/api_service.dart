import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../model/movie_model.dart';

class ApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: {
        "Authorization":"Bearer ${ApiConstants.bearerToken}",
        "Content-Type":"application/json",
      },
    ),
  );

  // Trending movies
  Future<List<Movie>> getTrendingMovies() async {
    try{
      final response = await dio.get(
        ApiConstants.trending,
      );
      if(response.statusCode == 200) {
        List results = response.data['results'];
        return results
            .map<Movie>((movie) => Movie.fromJson(movie))
            .toList();
      }else{
        throw Exception("Failed to load Trending movies");
      }

    }on DioException catch(e) {
      throw Exception("Trending API Error: ${e.message}");
    }
  }

  // Popular Movies
  Future<List<Movie>> getPopularMovies() async {
    try {
      final response = await dio.get(
        ApiConstants.popular,
      );

      if(response.statusCode == 200) {
        List results = response.data['results'];
        return results
            .map<Movie>((movie) => Movie.fromJson(movie))
            .toList();
      }else{
        throw Exception("Failed to load Popular movies");
      }
    }on DioException catch(e) {
      throw Exception("Popular API Error:${e.message}");
    }
  }

  // search movies
  Future<List<Movie>>searchMovies(String query) async {
    try{
      final response = await dio.get(
        ApiConstants.search,
        queryParameters: {
          "query":query,
        },
      );

      if(response.statusCode == 200) {
        List results = response.data['results'];
        return results
            .map<Movie>((movie) => Movie.fromJson(movie))
            .toList();
      }else{
        throw Exception("Failed to search Movies");
      }
    }on DioException catch (e) {
      throw Exception("Serach API Error: ${e.message}");
    }
  }
}