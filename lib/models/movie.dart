class MovieList {
  int id;
  String title;
  String originalLanguage;
  double popularity;
  String posterPath;
  String backdropPath;
  String releaseDate;

  MovieList(
      {required this.id,
      required this.title,
      required this.originalLanguage,
      required this.popularity,
      required this.posterPath,
      required this.backdropPath,
      required this.releaseDate});

  factory MovieList.fromJson(Map<String, dynamic> _json) {
    return MovieList(
        id: _json['id'],
        title: _json['title'],
        originalLanguage: _json['original_language'],
        popularity: _json['popularity'],
        posterPath:
            "https://image.tmdb.org/t/p/original" + _json['poster_path'],
        backdropPath: _json['backdrop_path'] != null
            ? "https://image.tmdb.org/t/p/original" + _json['backdrop_path']
            : 'https://placehold.jp/F5c76b/002c6a/728x400.png?text=No%20Image',
        releaseDate: _json['release_date']);
  }
}

class MovieDetail {
  int id;
  String title;
  String originalLanguage;
  double popularity;
  String posterPath;
  String backdropPath;
  String releaseDate;
  List<String> genres;
  double voteAverage;
  String overview;
  String language;
  int runtime;

  MovieDetail({
    required this.id,
    required this.title,
    required this.originalLanguage,
    required this.popularity,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.genres,
    required this.voteAverage,
    required this.overview,
    required this.runtime,
    required this.language,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> _json) {
    return MovieDetail(
        id: _json['id'],
        title: _json['title'],
        originalLanguage: _json['original_language'],
        popularity: _json['popularity'],
        posterPath:
            "https://image.tmdb.org/t/p/original" + _json['poster_path'],
        backdropPath: _json['backdrop_path'] != null
            ? "https://image.tmdb.org/t/p/original" + _json['backdrop_path']
            : 'https://placehold.jp/F5c76b/002c6a/728x400.png?text=No%20Image',
        releaseDate: _json['release_date'],
        genres: List<Map<String, dynamic>>.from(_json['genres'])
            .map((genre) => genre['name'].toString())
            .toList(),
        voteAverage: _json['vote_average'],
        language: _json['spoken_languages'][0]['name'],
        overview: _json['overview'],
        runtime: _json['runtime']);
  }
}

class MovieDetailCast {
  int id;
  String name;
  String character;
  String profilePath;

  MovieDetailCast({
    required this.id,
    required this.name,
    required this.character,
    required this.profilePath,
  });

  factory MovieDetailCast.fromJson(Map<String, dynamic> _json) {
    return MovieDetailCast(
      id: _json['id'],
      name: _json['name'],
      character: _json['character'],
      profilePath: _json['profile_path'] != null
          ? "https://image.tmdb.org/t/p/original" + _json['profile_path']
          : 'https://placehold.jp/F5c76b/002c6a/728x400.png?text=No%20Image',
    );
  }
}
