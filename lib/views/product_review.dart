import 'package:flutter/material.dart';
import '../services/auth/auth_service.dart';
import '../widgets/ratingsystem/starwidgets.dart';

class ProductReviewPageTwo extends StatelessWidget {
  ProductReviewPageTwo(
      {super.key, this.qrCodeString, required this.productName});

  final String productName;
  final String? qrCodeString;

  final GlobalKey<RefreshIndicatorState> _refreshpage =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<ChildrenListState> _childrenListKey =
      GlobalKey<ChildrenListState>();
  String get userId => AuthService.firebase().currentUser!.id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(productName)),
      body: RefreshIndicator(
        key: _refreshpage,
        onRefresh: () async {
          await _childrenListKey.currentState!.refreshChildren();
          /* final state = _refreshpage.currentState!.context
              .findAncestorStateOfType<AverageRatingState>();
          if (state != null) {
            await state.refreshReviews();
      } */
        },
        child: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  Center(
                      child: ChildrenList(
                    key: _childrenListKey,
                    qrCodeString: qrCodeString,
                    userId: userId,
                  ))
                  /* AverageRating(qrCodeString: qrCodeString),
                  ReviewInput(
                    qrCodeString: qrCodeString,
                    userId: userId,
                  ),
                  ProductReviews(productId: qrCodeString) */
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChildrenList extends StatefulWidget {
  const ChildrenList({super.key, this.qrCodeString, required this.userId});
  final String? qrCodeString;
  final String userId;

  @override
  State<ChildrenList> createState() => ChildrenListState();
}

class ChildrenListState extends State<ChildrenList> {
  Future<void> refreshChildren() async {
    // This is where you can trigger the data fetch or other operations needed for refreshing.
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AverageRating(qrCodeString: widget.qrCodeString),
        ReviewInput(
          qrCodeString: widget.qrCodeString,
          userId: widget.userId,
        ),
        ProductReviews(productId: widget.qrCodeString)
      ],
    );
  }
}
