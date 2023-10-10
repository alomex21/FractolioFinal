import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fractoliotesting/services/utilities/extensions.dart';

class AverageRating extends StatefulWidget {
  final String? qrCodeString;

  const AverageRating({super.key, required this.qrCodeString});

  @override
  State<AverageRating> createState() => AverageRatingState();
}

class AverageRatingState extends State<AverageRating> {
  // Introduce a controller to listen for stream updates
  late StreamController<QuerySnapshot> _controller;
  late Stream<QuerySnapshot> reviewsStream;

  @override
  void initState() {
    super.initState();

    _controller = StreamController();
    reviewsStream = FirebaseFirestore.instance
        .collection('Products')
        .doc(widget.qrCodeString)
        .collection('reviews')
        .snapshots();

    _controller.addStream(reviewsStream);
  }

  // Function to refresh the reviews
  Future<void> refreshReviews() async {
    _controller.addStream(reviewsStream);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _controller.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final reviews = snapshot.data!.docs;
          double totalRating = 0.0;

          for (var review in reviews) {
            totalRating += review.get('rating');
          }

          double averageRating =
              reviews.isNotEmpty ? totalRating / reviews.length : 0;
          double roundedAverage = averageRating.toPrecision(2);

          return Text('Average Rating: $roundedAverage');
        }

        return const CircularProgressIndicator();
      },
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}

class ReviewInput extends StatefulWidget {
  final String? qrCodeString;
  final String userId;

  const ReviewInput(
      {super.key, required this.qrCodeString, required this.userId});

  @override
  State<ReviewInput> createState() => _ReviewInputState();
}

class _ReviewInputState extends State<ReviewInput> {
  double _currentRating = 0;
  String _currentReview = '';
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
                .collection('Products')
                .doc(widget.qrCodeString)
                .collection('reviews')
                .doc(widget.userId)
                .set({
              'user_id': widget.userId,
              'rating': _currentRating,
              'text': _currentReview,
            }, SetOptions(merge: true));

            /* await FirebaseFirestore.instance
                .collection('Products')
                .doc(widget.qrCodeString)
                .collection('reviews')
                .add({
              'user_id': widget
                  .userId, // Ideally get this from Firebase Auth or your user system
              'rating': _currentRating,
              'text': _currentReview,
            }); */
          },
          child: const Text('Submit Review'),
        ),
      ],
    );
  }
}
