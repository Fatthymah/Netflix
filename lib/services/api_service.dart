import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../model/movie_model.dart';

class ApiService {

  final Dio dio = Dio();


  Future<List<Movie>> getTrendingMovies() async {

    final url =
        "${ApiConstants.baseUrl}${ApiConstants.trending}?api_key=${ApiConstants.apiKey}";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      List results = decoded['results'];
      return results.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Failed to load Trending Movies");
    }
  }

  // popular movies using dio
  Future<List<Movie>> getPopularMovies() async {

    final url = "${ApiConstants.baseUrl}${ApiConstants.popular}";

    final response = await dio.get(
      url,
      options: Options(
        headers: {
          "Authorization": "Bearer ${ApiConstants.bearerToken}",
          "Content-Type": "application/json"
        },
      ),
    );

    if (response.statusCode == 200) {
      List results = response.data['results'];
      return results.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Failed to load Popular Movies");
    }
  }
}