import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/app/theme/colors.dart';
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
                        style: Get.textTheme.bodyLarge
                            ?.copyWith(fontFamily: Fonts.poppinsMedium),
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
                      color: Colors.green.withAlpha(30),
                      borderRadius: BorderRadius.circular(8)),
                  child: InkWell(
                    onTap: () => editAddedProduct(product),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: Icon(
                        Icons.edit_note_sharp,
                        color: AppColors.buttonColorAlternate,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8,),
            Divider(height: 1, thickness: 1, color: Colors.grey.shade300,),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "P. ",
                        style: Get.textTheme.bodyMedium
                            ?.copyWith(fontFamily: Fonts.poppinsMedium),
                      ),
                      Text(
                        "${product.packing}",
                        style: Get.textTheme.bodyMedium
                            ?.copyWith(fontFamily: Fonts.poppinsBold),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "U. ",
                        style: Get.textTheme.bodyMedium
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
                VerticalDivider(
                  width: 1,
                  color: Colors.grey,
                  thickness: 1,
                ),
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Q. ",
                        style: Get.textTheme.bodyMedium
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
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "P. ",
                        style: Get.textTheme.bodyMedium
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
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "T. ",
                        style: Get.textTheme.bodyMedium
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
