class AddedProductUiModel {
  final String? productName;
  final String? packing;
  final String? unit;
  final int? quantity;

  const AddedProductUiModel({
    this.productName,
    this.packing,
    this.unit,
    this.quantity,
  });

  AddedProductUiModel copyWith({
    String? productName,
    String? packing,
    String? unit,
    int? quantity,
  }) {
    return AddedProductUiModel(
      productName: productName ?? this.productName,
      packing: packing ?? this.packing,
      unit: unit ?? this.unit,
      quantity: quantity ?? this.quantity,
    );
  }
}
