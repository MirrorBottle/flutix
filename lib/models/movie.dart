class MovieList {
  int id;
  String title;
  String originalLanguage;
  double popularity;
  String posterPath;
  String backdropPath;
  String releaseDate;

  MovieList({
    required this.id,
    required this.title,
    required this.originalLanguage,
    required this.popularity,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate
  });

  factory MovieList.fromJson(Map<String, dynamic> _json) {
    return MovieList(
      id: _json['id'],
      title: _json['title'],
      originalLanguage: _json['original_language'],
      popularity: _json['popularity'],
      posterPath: "https://image.tmdb.org/t/p/original" + _json['poster_path'],
      backdropPath: _json['backdrop_path'] != null ? "https://image.tmdb.org/t/p/original" + _json['backdrop_path'] : 'https://placehold.jp/F5c76b/002c6a/728x400.png?text=No%20Image',
      releaseDate: _json['release_date']
    );
  }
}