class AddProduct {
  AddProduct(this.productName, this.qrCode, this.description, this.imageUrl,
      this.allergens, this.nutritionalValues);

  final List<String> allergens;
  final String description;
  final String imageUrl;
  final Map<String, String> nutritionalValues;
  final String productName;
  final String qrCode;

  Map<String, dynamic> toJson() => {
        'product_name': productName,
        'qr_code': qrCode,
        'description': description,
        'image_url': imageUrl,
        'allergens': allergens,
        'nutritional_values': nutritionalValues,
      };
}
