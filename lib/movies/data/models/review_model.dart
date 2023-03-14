import 'package:movies_app/core/utils/functions.dart';
import 'package:movies_app/movies/domain/entities/review.dart';

class ReviewModel extends Review {
  const ReviewModel({
    required super.authorName,
    required super.authorUserName,
    required super.avatarUrl,
    required super.rating,
    required super.content,
    required super.elapsedTime,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      authorName: json['author'],
      authorUserName: '@${json['author_details']['username']}',
      avatarUrl: getAvatarUrl(json['author_details']['avatar_path']),
      rating: json['author_details']['rating'] != null
          ? json['author_details']['rating'] / 2
          : -1,
      content: json['content'],
      elapsedTime: getElapsedTime(json['created_at']),
    );
  }
}
