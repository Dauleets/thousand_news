import 'package:hive/hive.dart';
part 'news_models.g.dart';

@HiveType(typeId: 0)
class News {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? overview;
  @HiveField(3)
  final String? posterPath;
  @HiveField(4)
  final String? releaseDate;
  @HiveField(5)
  final double? voteAverage;

  News({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      voteAverage: json['vote_average'],
    );
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! News) return false;
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
