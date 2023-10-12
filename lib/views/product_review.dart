import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fractoliotesting/services/auth/auth_service.dart';
import 'package:fractoliotesting/widgets/ratingsystem/starwidgets.dart';

class ProductReviewPageTwo extends StatelessWidget {
  ProductReviewPageTwo(
      {super.key, this.qrCodeString, required this.productName});
  final String? qrCodeString;
  final String productName;
  String get userId => AuthService.firebase().currentUser!.id;
  final GlobalKey<RefreshIndicatorState> _refreshpage =
      GlobalKey<RefreshIndicatorState>();

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

class ProductReviewPage extends StatelessWidget {
  const ProductReviewPage(
      {super.key, required this.productName, required this.productId});
  final String productName;
  final String? productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(productName),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              RatingBar.builder(
                allowHalfRating: true,
                initialRating: 3,
                minRating: 1,
                maxRating: 5,
                direction: Axis.horizontal,
                wrapAlignment: WrapAlignment.center,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (selectedrating) {
                  print(selectedrating);
                },
              ),
            ],
          ),
        ));
  }
}
