import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fractoliotesting/widgets/ratingsystem/starwidgets.dart';

class ProductReviewPageTwo extends StatelessWidget {
  const ProductReviewPageTwo(
      {super.key, this.qrCodeString, required this.productName});
  final String? qrCodeString;
  final String productName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(productName)),
      body: Center(
        child: Column(
          children: [
            AverageRating(qrCodeString: qrCodeString),
            ReviewInput(qrCodeString: qrCodeString)
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
    double _rating;
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
