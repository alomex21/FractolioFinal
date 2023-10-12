import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fractoliotesting/models/review.dart';
import 'package:fractoliotesting/services/services/database_services.dart';

class FirestoreService implements DatabaseService {
  // Singleton instance
  static final FirestoreService _instance = FirestoreService._internal();

  // Firebase instance
  final FirebaseFirestore _firebaseInstance = FirebaseFirestore.instance;

  // Private constructor
  FirestoreService._internal();

  // Factory constructor
  factory FirestoreService() {
    return _instance;
  }

  @override
  Future<void> setReview(
      String? productId, String userId, double rating, String reviewText,
      {bool merge = false}) async {
    return await _firebaseInstance
        .collection('Products')
        .doc(productId)
        .collection('reviews')
        .doc(userId)
        .set({
      'user_id': userId,
      'rating': rating,
      'text': reviewText,
    }, SetOptions(merge: merge));
  }

  @override
  Future<String> getUsername(String? userId) async {
    DocumentSnapshot userDoc =
        await _firebaseInstance.collection('users').doc(userId).get();
    return userDoc.get('username') as String;
  }

  @override
  Stream<double> fetchProductAverageRating(String? productId) {
    return _firebaseInstance
        .collection('Products')
        .doc(productId)
        .collection('reviews')
        .snapshots()
        .map((snapshot) {
      double totalRating = 0.0;
      for (var review in snapshot.docs) {
        totalRating += review.get('rating');
      }
      return snapshot.docs.isNotEmpty ? totalRating / snapshot.docs.length : 0;
    });
  }

  @override
  Stream<List<Review>> fetchProductReviews(String? productId) {
    return _firebaseInstance
        .collection('Products')
        .doc(productId)
        .collection('reviews')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return Review(
                userId: doc.get('user_id'),
                rating: doc.get('rating').toDouble(),
                text: doc.get('text'),
              );
            }).toList());
  }

  @override
  Future<Review?> getUserReview(String? productId, String userId) async {
    final userReviewDoc = await _firebaseInstance
        .collection('Products')
        .doc(productId)
        .collection('reviews')
        .doc(userId)
        .get();

    if (userReviewDoc.exists) {
      return Review(
        userId: userReviewDoc.get('user_id'),
        rating: userReviewDoc.get('rating').toDouble(),
        text: userReviewDoc.get('text'),
      );
    }
    return null;
  }
}
