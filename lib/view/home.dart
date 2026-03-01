import 'package:flutter/material.dart';
import 'package:netflix/constants/api_constants.dart';
import 'package:netflix/controller/movie_controller.dart';
import 'package:provider/provider.dart';
import '../model/movie_model.dart';
import 'package:netflix/view/details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MovieController>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: const Text(
            "Netflix",
            style: TextStyle(
              color:Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 33,
              letterSpacing: 1,
            ),
          ),
        ),
      ),

      body: controller.isLoading
      ? const Center(child: CircularProgressIndicator())
      : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            if(controller.trendingMovies.isNotEmpty)
              _buildBanner(controller.trendingMovies[0]),

            _buildSectionTitle("Trending Now"),
            _buildMovieList(controller.trendingMovies),

             const SizedBox(height: 30),

             _buildSectionTitle("Popular"),
             _buildMovieList(controller.popularMovies),

             const SizedBox(height: 20),
            ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title){
    return Padding(
      padding:const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(
          color:Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBanner(Movie movie) {
    return Stack(
      children: [
        Image.network(
          "${ApiConstants.imageBase}${movie.posterPath}",
          height: 400,
          width: double.infinity,
          fit: BoxFit.cover,
        ),

        Container(
          height: 400,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.8),
                Colors.transparent,
                Colors.black,
              ],
              begin:Alignment.bottomCenter,
              end:Alignment.topCenter,
            ),
          ),
        ),

        Positioned(
          bottom: 30,
          left:20,
          child: Text(
            movie.title,
            style: const TextStyle(
              color:Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          bottom:20,
          left:20,
          child: Row(
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                onPressed: (){},
                icon:const Icon(Icons.play_arrow,color:Colors.black),
                label: const Text(
                  "Play",
                  style: TextStyle(color:Colors.black),
                ),
              ),
              const SizedBox(width:10),

              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side:const BorderSide(color:Colors.white),
                ),
                onPressed: (){},
                icon:const Icon(Icons.info_outline,color:Colors.white),
                label:const Text(
                  "Info",
                  style: TextStyle(color:Colors.white),
                )
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildMovieList(List<Movie> movies) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {

          final movie = movies[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child:GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_)=> MovieDetailsScreen(movie: movie),
                  ),
                );
              },

              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "${ApiConstants.imageBase}${movie.posterPath}",
                  width: 130,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}