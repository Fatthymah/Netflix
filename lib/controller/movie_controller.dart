import 'package:flutter/material.dart';
import 'package:netflix/model/movie_model.dart';
import 'package:netflix/services/api_service.dart';

// in controller calls api , stores movies and tells ui to rebuild

class MovieController extends ChangeNotifier {
  final ApiService apiService = ApiService();

  List<Movie> trendingMovies = [];
  List<Movie> popularMovies = [];

  bool isLoading = false;

  Future<void>fetchMovies() async {
    isLoading = true;
    notifyListeners();

    try{
      trendingMovies = await apiService.getTrendingMovies();
      popularMovies = await apiService.getPopularMovies();
    }catch(e) {
      debugPrint("Error Fetching Movies:$e");
    }

    isLoading = false;
    notifyListeners();
  }

  List<Movie> searchResults = [];
  Future<void> searchMovie(String query) async {
    if(query.isEmpty){
      searchResults = [];
      notifyListeners();
      return;
    }
    isLoading = true;
    notifyListeners();

    try {
      searchResults = await apiService.searchMovies(query);
    }catch(e) {
      debugPrint("Search Error: $e");
    }
    isLoading = false;
    notifyListeners();
  }
}