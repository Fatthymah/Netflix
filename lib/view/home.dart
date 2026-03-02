import 'package:flutter/material.dart';
import 'package:netflix/constants/api_constants.dart';
import 'package:netflix/controller/movie_controller.dart';
import 'package:provider/provider.dart';
import '../model/movie_model.dart';
import 'package:netflix/view/details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final controller = context.watch<MovieController>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text(
            "Netflix",
            style: TextStyle(
              color: Colors.red,
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

            // search bar
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: searchController,
                onSubmitted: (value) {
                  context.read<MovieController>().searchMovie(value);
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search Movies...",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  filled: true,
                  fillColor: Colors.black45,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // search result
            Consumer<MovieController>(
              builder: (context, controller, child) {

                if (controller.searchResults.isEmpty) {
                  return const SizedBox();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    _buildSectionTitle("Search Results"),

                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.searchResults.length,
                        itemBuilder: (context, index) {

                          final movie = controller.searchResults[index];

                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MovieDetailsScreen(movie: movie),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  "${ApiConstants.imageBase}${movie.posterPath}",
                                  width: 130,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),

            // banner
            if (controller.searchResults.isEmpty && controller.trendingMovies.isNotEmpty)
              _buildBanner(controller.trendingMovies[0]),

            if(controller.searchResults.isEmpty) ...[
              _buildSectionTitle("Trending Now"),
              _buildMovieList(controller.trendingMovies),

              const SizedBox(height: 30),

              _buildSectionTitle("Popular"),
              _buildMovieList(controller.popularMovies),

              const SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
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
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),

        Positioned(
          bottom: 30,
          left: 20,
          child: Text(
            movie.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MovieDetailsScreen(movie: movie),
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