import '../models/thumbnail.dart';

class Series {
  final int id;
  final String title;
  final String? description;
  final int startYear;
  final Thumbnail thumbnail;

  Series({
    required this.id,
    required this.title,
    this.description,
    required this.startYear,
    required this.thumbnail,
  });

  factory Series.fromJson(Map<String, dynamic> json) {
    return Series(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      startYear: json['startYear'],
      thumbnail: Thumbnail.fromJson(json['thumbnail']),
    );
  }
}
