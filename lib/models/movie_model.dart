class Movie {
  final String id;
  final String title;
  final int year;
  final String director;
  final String poster;
  final String totalWhoas;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.director,
    required this.poster,
    required this.totalWhoas,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['_id'] ?? '',
      title: json['movie'] ?? 'No Title',
      year: json['year'] ?? 0,
      director: json['director'] ?? 'Unknown',
      poster: json['poster'] ?? '',
      totalWhoas: json['total_whoas_in_movie']?.toString() ?? '0',
    );
  }
}
