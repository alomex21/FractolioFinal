class Review {
  Review({
    required this.userId,
    required this.rating,
    required this.text,
  });

  final double rating;
  final String text;
  final String userId;
}
