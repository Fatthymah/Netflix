class Movie {
  final String title;
  final String posterPath;
  final String overview;
  final double rating;
  final String releaseDate;

  Movie({
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.rating,
    required this.releaseDate,
});

  factory Movie.fromJson(Map<String,dynamic> json){
    return Movie(
      title: json['title'] ?? "",
      posterPath: json['poster_path'] ?? "",
      overview: json['overview'] ?? "",
      rating: (json['vote_average'] ?? 0).toDouble(),
      releaseDate: json['release_data'] ?? "",
    );
  }
}