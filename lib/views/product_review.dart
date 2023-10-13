import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../services/auth/auth_service.dart';
import '../widgets/ratingsystem/starwidgets.dart';

class ProductReviewPageTwo extends StatelessWidget {
  ProductReviewPageTwo(
      {super.key, this.qrCodeString, required this.productName});

  final String productName;
  final String? qrCodeString;

  final GlobalKey<RefreshIndicatorState> _refreshpage =
      GlobalKey<RefreshIndicatorState>();

  String get userId => AuthService.firebase().currentUser!.id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(productName)),
      body: RefreshIndicator(
        key: _refreshpage,
        onRefresh: () async {
          final state = _refreshpage.currentState!.context
              .findAncestorStateOfType<AverageRatingState>();
          if (state != null) {
            await state.refreshReviews();
          }
        },
        child: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  AverageRating(qrCodeString: qrCodeString),
                  ReviewInput(
                    qrCodeString: qrCodeString,
                    userId: userId,
                  ),
                  ProductReviews(productId: qrCodeString)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
