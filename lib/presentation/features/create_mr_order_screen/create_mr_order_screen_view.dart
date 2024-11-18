import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/app/theme/colors.dart';
import 'package:suhol_van_sales/app/theme/fonts.dart';
import 'package:suhol_van_sales/presentation/utils/extensions.dart';
import 'package:suhol_van_sales/presentation/utils/number_text_input_formatter.dart';
import 'package:suhol_van_sales/presentation/widgets/app_button.dart';
import 'package:suhol_van_sales/presentation/widgets/my_app_bar.dart';
import 'package:suhol_van_sales/presentation/widgets/user_info.dart';

import '../../widgets/app_text_field.dart';
import 'create_mr_order_screen_controller.dart';

class CreateMrOrderScreen extends StatefulWidget {
  const CreateMrOrderScreen({super.key});

  @override
  State<CreateMrOrderScreen> createState() => _CreateMrOrderScreenState();
}

class _CreateMrOrderScreenState extends State<CreateMrOrderScreen> {
  final CreateMrOrderScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        leadingWidth: 12,
        title: UserInfo(
          userName: controller.userName,
          shopName: controller.shopName,
          back: controller.pop,
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: context.height * .02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width * .95,
                  //height: isHeightInfinite ? null : height * .07,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: AppTextField(
                          hint: "Division Name",
                          width: Get.width * .45,
                          fieldType: FieldType.autocomplete,
                          searchController: controller.divisionName!,
                          capitalization: TextCapitalization.words,
                          inputAction: TextInputAction.next,
                          suggestionsBuilder: controller.finddivisionName,
                          onSelectResult: controller.onSelectdivisionName,
                          suggestionDisplayOption: (customer) =>
                              customer.divisionName ?? "",
                          prefixIcon: const Icon(
                            Icons.person_2,
                            color: Colors.grey,
                          ),
                          autoFocus: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: ColoredBox(
                            color: AppColors.buttonColorAlternate,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: InkWell(
                                  onTap: controller.onClickSenddivisionName,
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * .02,
                ),
                SizedBox(
                  width: Get.width * .95,
                  //height: isHeightInfinite ? null : height * .07,
                  child: AppTextField(
                    hint: "Product Name",
                    inputAction: TextInputAction.next,
                    prefixIcon: const Icon(
                      Icons.production_quantity_limits,
                      color: Colors.grey,
                    ),
                    searchController: controller.productName!,
                    capitalization: TextCapitalization.words,
                    suggestionsBuilder: controller.findProductName,
                    onSelectResult: controller.onSelectProduct,
                    suggestionDisplayOption: (product) => product.name ?? "",
                    fieldType: FieldType.autocomplete,
                    autoFocus: false,
                    suggestionConstraints: AppTextField.fixedBoxConstraints(),
                  ),
                ),
                SizedBox(
                  height: Get.height * .02,
                ),
                SizedBox(
                  width: Get.width * .95,
                  //height: isHeightInfinite ? null : height * .07,
                  child: Row(
                    children: [
                      Expanded(
                        child: Obx(() => AppTextField(
                              hint: "Packing",
                              searchController: controller.packing!,
                              capitalization: TextCapitalization.words,
                              inputAction: TextInputAction.next,
                              prefixIcon: const Icon(
                                Icons.backpack,
                                color: Colors.grey,
                              ),
                              fieldType:
                                  controller.selectedProduct.value != null
                                      ? FieldType.autocomplete
                                      : FieldType.normal,
                              suggestionConstraints:
                                  AppTextField.fixedBoxConstraints(),
                              suggestionsBuilder: controller.findProductPacking,
                              onSelectResult: controller.onSelectProductPacking,
                              suggestionDisplayOption: (p0) =>
                                  p0.packing ?? "None",
                              autoFocus: false,
                            )),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Obx(() => AppTextField(
                              hint: "Unit",
                              searchController: controller.unit!,
                              inputAction: TextInputAction.next,
                              prefixIcon: const Icon(
                                Icons.ad_units,
                                color: Colors.grey,
                              ),
                              suggestionsBuilder: controller.findProductUnit,
                              onSelectResult: controller.onSelectProductUnit,
                              suggestionDisplayOption: (p0) =>
                                  p0.name?.name ?? "None",
                              fieldType:
                                  controller.selectedProduct.value != null
                                      ? FieldType.autocomplete
                                      : FieldType.normal,
                              suggestionConstraints:
                                  AppTextField.fixedBoxConstraints(),
                            )),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: AppTextField(
                          hint: "Qty",
                          controller: controller.qty!,
                          inputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          prefixIcon: const Icon(
                            Icons.confirmation_number,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * .02,
                ),
                SizedBox(
                  width: Get.width * .95,
                  // height: isHeightInfinite ? null : height * .07,
                  child: Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          hint: "Price",
                          controller: controller.price!,
                          inputAction: TextInputAction.next,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true, signed: true),
                          prefixIcon: const Icon(
                            Icons.price_change,
                            color: Colors.grey,
                          ),
                          inputFormatters: [NumberTextInputFormatter()],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AppTextField(
                          hint: "Remarks",
                          controller: controller.remarks!,
                          inputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          capitalization: TextCapitalization.words,
                          prefixIcon: const Icon(
                            Icons.note_alt_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * .02,
                ),
                SizedBox(
                  width: Get.width * .95,
                  child: Row(
                    children: [
                      Expanded(
                        child: Obx(() => AppButton(
                              onClick: controller.onSubmitOrder,
                              height: 40,
                              btnColor: AppColors.buttonColor,
                              border: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              showLoading: controller.orderLoading.value,
                              child: Text(
                                "SUBMIT ORDER",
                                style: Get.textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                    fontFamily: Fonts.poppinsMedium),
                              ).fitBox(),
                            )),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Obx(() => AppButton(
                              onClick: controller.onAddItem,
                              height: 40,
                              btnColor: AppColors.buttonColorAlternate,
                              showLoading: controller.addItemLoading.value,
                              border: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                "ADD ITEM",
                                style: Get.textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                    fontFamily: Fonts.poppinsMedium),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Obx(() => ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 6,
                  ),
                  itemCount: controller.addedProducts.length,
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var request = controller.addedProducts[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
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
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Product",
                                        style: Get.textTheme.bodySmall
                                            ?.copyWith(
                                                fontFamily: Fonts.poppinsBold),
                                      ),
                                      Text(
                                        "${request.productName}",
                                        style: Get.textTheme.bodyMedium
                                            ?.copyWith(
                                                fontFamily: Fonts.poppinsBold),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent.withAlpha(30),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: IconButton(
                                      onPressed: () => controller
                                          .deleteAddedProduct(request),
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                      )),
                                )
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Packing",
                                        style: Get.textTheme.bodySmall
                                            ?.copyWith(
                                                fontFamily: Fonts.poppinsBold),
                                      ),
                                      Text(
                                        "${request.packing}",
                                        style: Get.textTheme.bodyMedium
                                            ?.copyWith(
                                                fontFamily: Fonts.poppinsBold),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Unit",
                                        style: Get.textTheme.bodySmall
                                            ?.copyWith(
                                                fontFamily: Fonts.poppinsBold),
                                      ),
                                      Text(
                                        "${request.unit}",
                                        style: Get.textTheme.bodyMedium
                                            ?.copyWith(
                                                fontFamily: Fonts.poppinsBold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ))
          ],
        ),
      )),
    );
  }

  @override
  void dispose() {
    Get.delete<CreateMrOrderScreenController>();
    super.dispose();
  }
}
