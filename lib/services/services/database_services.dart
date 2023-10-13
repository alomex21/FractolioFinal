import 'package:fractoliotesting/models/review.dart';

abstract class DatabaseService {
  Future<void> setReview(
      String productId, String userId, double rating, String reviewText,
      {bool merge});

  Future<String> getUsername(String userId);

  Stream<double> fetchProductAverageRating(String? productId);

  Stream<List<Review>> fetchProductReviews(String? productId);

  Future<Review?> getUserReview(String? productId, String userId);
}
