import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/app/theme/fonts.dart';
import 'package:suhol_van_sales/presentation/models/added_product_ui_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {super.key,
      required this.product,
      required this.editAddedProduct,
      this.serialNo});

  final AddedProductUiModel product;
  final void Function(AddedProductUiModel) editAddedProduct;
  final String? serialNo;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$serialNo. ",
                        style: Get.textTheme.bodySmall
                            ?.copyWith(fontFamily: Fonts.poppinsBold),
                      ),
                      Text(
                        "${product.productName}",
                        style: Get.textTheme.bodyLarge
                            ?.copyWith(fontFamily: Fonts.poppinsBold),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.redAccent.withAlpha(30),
                      borderRadius: BorderRadius.circular(12)),
                  child: IconButton(
                      onPressed: () => editAddedProduct(product),
                      icon: const Icon(
                        Icons.edit_note_sharp,
                        color: Colors.redAccent,
                      )),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "P.",
                        style: Get.textTheme.bodySmall
                            ?.copyWith(fontFamily: Fonts.poppinsRegular),
                      ),
                      Text(
                        "${product.packing}",
                        style: Get.textTheme.bodyMedium
                            ?.copyWith(fontFamily: Fonts.poppinsBold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "U. ",
                        style: Get.textTheme.bodySmall
                            ?.copyWith(fontFamily: Fonts.poppinsRegular),
                      ),
                      Text(
                        "${product.unit}",
                        style: Get.textTheme.bodyMedium
                            ?.copyWith(fontFamily: Fonts.poppinsBold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Q. ",
                        style: Get.textTheme.bodySmall
                            ?.copyWith(fontFamily: Fonts.poppinsRegular),
                      ),
                      Text(
                        "${product.quantity}",
                        style: Get.textTheme.bodyMedium
                            ?.copyWith(fontFamily: Fonts.poppinsBold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "P. ",
                        style: Get.textTheme.bodySmall
                            ?.copyWith(fontFamily: Fonts.poppinsRegular),
                      ),
                      Text(
                        "${product.price}",
                        style: Get.textTheme.bodyMedium
                            ?.copyWith(fontFamily: Fonts.poppinsBold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "T. ",
                        style: Get.textTheme.bodySmall
                            ?.copyWith(fontFamily: Fonts.poppinsRegular),
                      ),
                      Text(
                        "${(product.price ?? 1) * (product.quantity ?? 0)}",
                        style: Get.textTheme.bodyMedium
                            ?.copyWith(fontFamily: Fonts.poppinsBold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
