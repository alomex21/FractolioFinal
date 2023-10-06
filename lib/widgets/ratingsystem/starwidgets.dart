import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AverageRating extends StatelessWidget {
  final String? qrCodeString;

  const AverageRating({super.key, required this.qrCodeString});

/*   final Stream<QuerySnapshot> reviewsStream = FirebaseFirestore.instance
      .collection('Products')
      .doc(qrCodeString)
      .collection('reviews')
      .snapshots(); */

  @override
  Widget build(BuildContext context) {
    final reviewsStream = FirebaseFirestore.instance
        .collection('Products')
        .doc(qrCodeString)
        .collection('reviews')
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: reviewsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final reviews = snapshot.data!.docs;
          double totalRating = 0.0;

          for (var review in reviews) {
            totalRating += review.get('rating');
          }

          double averageRating =
              reviews.isNotEmpty ? totalRating / reviews.length : 0;

          return Text('Average Rating: $averageRating');
        }

        return const CircularProgressIndicator(); // Loading indicator while fetching data
      },
    );
  }
}

class ReviewInput extends StatefulWidget {
  final String? qrCodeString;

  const ReviewInput({super.key, required this.qrCodeString});

  @override
  State<ReviewInput> createState() => _ReviewInputState();
}

class _ReviewInputState extends State<ReviewInput> {
  double _currentRating = 0;
  String _currentReview = ''; // Store the user's written review

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RatingBar.builder(
          initialRating: 0,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) =>
              const Icon(Icons.star, color: Colors.amber),
          onRatingUpdate: (rating) {
            setState(() {
              _currentRating = rating;
            });
          },
        ),
        TextField(
          // Input field for the written review
          onChanged: (value) {
            _currentReview = value;
          },
          decoration: const InputDecoration(
            hintText: "Write your review here...",
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            // Save to Firestore
            await FirebaseFirestore.instance
                .collection('products')
                .doc(widget.qrCodeString)
                .collection('reviews')
                .add({
              'user_id':
                  "your_current_user_id", // Ideally get this from Firebase Auth or your user system
              'rating': _currentRating,
              'text': _currentReview,
            });
          },
          child: const Text('Submit Review'),
        ),
      ],
    );
  }
}
