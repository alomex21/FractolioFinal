import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../models/review.dart';
import 'package:fractoliotesting/services/services/firestore_service.dart';

class AverageRating extends StatefulWidget {
  const AverageRating({super.key, required this.qrCodeString});

  final String? qrCodeString;

  @override
  State<AverageRating> createState() => AverageRatingState();
}

class AverageRatingState extends State<AverageRating> {
  final dbService = FirestoreService();

  late Stream<double> _averageRatingStream;

  @override
  void initState() {
    super.initState();
    _averageRatingStream =
        dbService.fetchProductAverageRating(widget.qrCodeString!);
  }

  Future<void> refreshReviews() async {
    setState(
      () {
        _averageRatingStream =
            dbService.fetchProductAverageRating(widget.qrCodeString!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
      stream: _averageRatingStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.hasData) {
            double averageRating = snapshot.data!;
            double roundedAverage = (averageRating * 100).roundToDouble() / 100;
            return Text('Average Rating: $roundedAverage');
          }
        }

        return const CircularProgressIndicator();
      },
    );
  }
}

class ReviewInput extends StatefulWidget {
  const ReviewInput(
      {super.key, required this.qrCodeString, required this.userId});

  final String? qrCodeString;
  final String userId;

  @override
  State<ReviewInput> createState() => ReviewInputState();
}

class ReviewInputState extends State<ReviewInput> {
  FirestoreService dbService = FirestoreService();

  double _currentRating = 0;
  String _currentReview = '';
  bool _isLoading = false;
  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fetchUserReview();
  }

  Future<void> refreshUserReview() async {
    setState(
      () async {
        final userReview =
            await dbService.getUserReview(widget.qrCodeString!, widget.userId);
        if (userReview != null) {
          setState(() {
            _currentRating = userReview.rating;
            _currentReview = userReview.text;
          });
        }
      },
    );
  }

  Future<void> _fetchUserReview() async {
    final userReview =
        await dbService.getUserReview(widget.qrCodeString!, widget.userId);
    if (userReview != null) {
      setState(() {
        _currentRating = userReview.rating;
        _currentReview = userReview.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            RatingBar.builder(
              initialRating: _currentRating,
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
            Form(
              key: _key,
              child: TextFormField(
                onChanged: (value) {
                  _currentReview = value;
                },
                decoration: const InputDecoration(
                  hintText: "Write your review here...",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter a review';
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () async {
                      if (_key.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                          FocusScope.of(context).unfocus();
                        });
                        try {
                          await dbService.setReview(widget.qrCodeString,
                              widget.userId, _currentRating, _currentReview,
                              merge: true);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Review submitted successfully!'),
                                    backgroundColor: Colors.green));
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'An error occurred, please try again.'),
                                    backgroundColor: Colors.red));
                          }
                        } finally {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      }
                    },
              child: const Text('Submit Review'),
            ),
          ],
        ),
        if (_isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}

class ProductReviews extends StatefulWidget {
  const ProductReviews({super.key, required this.productId});

  final String? productId;

  @override
  State<ProductReviews> createState() => _ProductReviewsState();
}

class _ProductReviewsState extends State<ProductReviews> {
  final dbService = FirestoreService(); // Use the service

  late Stream<List<Review>> _reviewsStream;

  @override
  void initState() {
    super.initState();

    _reviewsStream = dbService.fetchProductReviews(widget.productId!);
  }

/*   Future<String> _getUsername(String userId) async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    return userDoc.get('username') as String;
  } */

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Review>>(
      stream: _reviewsStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        final reviews = snapshot.data!;

        return ListView.builder(
          shrinkWrap: true,
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            Review review = reviews[index];
            return FutureBuilder<String>(
              future: dbService.getUsername(review.userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ListTile(
                      title: Center(
                          child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator())));
                }

                String username = snapshot.data!;
                return ListTile(
                  title: Text(username),
                  subtitle: Text(review.text),
                  leading: CircleAvatar(
                    child: Text(review.rating.toString()),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
