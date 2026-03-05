import 'package:flutter/material.dart';
import 'package:netflix/constants/api_constants.dart';
import 'package:netflix/model/movie_model.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                _buildPoster(),

                Positioned(
                  top: 40,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "⭐ ${movie.rating}",
                    style: const TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Overview",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    movie.overview.isEmpty
                        ? "No overview available."
                        : movie.overview,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPoster() {
    // If no poster path → show fallback immediately
    if (movie.posterPath.isEmpty) {
      return Container(
        width: double.infinity,
        height: 400,
        color: Colors.grey[900],
        alignment: Alignment.center,
        child: const Icon(
          Icons.movie,
          color: Colors.white,
          size: 60,
        ),
      );
    }

    return Image.network(
      "${ApiConstants.imageBase}${movie.posterPath}",
      width: double.infinity,
      height: 400,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: double.infinity,
          height: 400,
          color: Colors.grey[900],
          alignment: Alignment.center,
          child: const Icon(
            Icons.movie,
            color: Colors.white,
            size: 60,
          ),
        );
      },
    );
  }
}