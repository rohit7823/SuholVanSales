import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:suhol_van_sales/app/theme/colors.dart';
import 'package:suhol_van_sales/app/theme/fonts.dart';
import 'package:suhol_van_sales/presentation/models/location_with_quantity_ui_model.dart';
import 'package:suhol_van_sales/presentation/utils/extensions.dart';
import 'package:suhol_van_sales/presentation/widgets/app_button.dart';
import 'package:suhol_van_sales/presentation/widgets/app_text_field.dart';
import 'package:suhol_van_sales/presentation/widgets/keyboard_aware_widget_two.dart';

import '../../widgets/my_app_bar.dart';
import '../../widgets/user_info.dart';
import 'create_credit_order_screen_controller.dart';

class CreateCreditOrderScreen extends StatefulWidget {
  const CreateCreditOrderScreen({super.key});

  @override
  State<CreateCreditOrderScreen> createState() =>
      _CreateCreditOrderScreenState();
}

class _CreateCreditOrderScreenState extends State<CreateCreditOrderScreen> {
  final controller = Get.find<CreateCreditOrderScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        leadingWidth: 12,
        title: UserInfo(
          userName: controller.userName,
          shopName: controller.shopName,
          back: controller.pop,
        ),
        actions: [
          IconButton(
            onPressed: controller.print,
            icon: const Icon(
              Icons.print,
              color: AppColors.buttonColorAlternate,
              size: 45,
            ),
          ).paddings(right: 10)
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: context.height * .02),
        child: Column(
          children: [
            KeyboardAwareWidgetTwo(
                child: (context, height, isHeightInfinite) => Column(
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
                                  hint: "Customer Name",
                                  width: Get.width * .45,
                                  fieldType: FieldType.autocomplete,
                                  searchController: controller.customerName!,
                                  capitalization: TextCapitalization.words,
                                  inputAction: TextInputAction.next,
                                  suggestionsBuilder:
                                      controller.findCustomerName,
                                  onSelectResult: controller.onSelectCustomer,
                                  suggestionDisplayOption: (customer) =>
                                      customer.name ?? "",
                                  prefixIcon: const Icon(
                                    Icons.person_2,
                                    color: Colors.grey,
                                  ),
                                  autoFocus: false,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: ColoredBox(
                                    color: AppColors.buttonColorAlternate,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: InkWell(
                                          onTap: controller
                                              .onClickSendCustomerName,
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
                          height: isHeightInfinite
                              ? Get.height * .02
                              : height * .02,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Obx(
                            () => MultiDropdown<LocationWithQuantityUiModel>(
                              items: const [],
                              controller:
                                  controller.userLocationDropdownController,
                              enabled: true,
                              searchEnabled: false,
                              chipDecoration: ChipDecoration(
                                  backgroundColor: Colors.blueAccent,
                                  wrap:
                                      controller.selectedLocations.length != 1,
                                  runSpacing: 2,
                                  spacing: 10,
                                  labelStyle: Get.textTheme.bodyMedium
                                      ?.copyWith(
                                          fontFamily: Fonts.dmSansBold,
                                          color: Colors.white)),
                              fieldDecoration: FieldDecoration(
                                hintText: 'Location',
                                hintStyle: Get.textTheme.titleMedium?.copyWith(
                                    color: Colors.grey.shade400,
                                    fontFamily: Fonts.dmSansSemiBold),
                                prefixIcon: const Icon(
                                  CupertinoIcons.location_fill,
                                  color: Colors.grey,
                                ),
                                showClearIcon: false,
                                backgroundColor: Colors.grey.shade200,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade200)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.lightBlueAccent)),
                              ),
                              dropdownDecoration: const DropdownDecoration(
                                marginTop: 2,
                                maxHeight: 500,
                                header: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Select locations from the list',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              dropdownItemDecoration: DropdownItemDecoration(
                                selectedIcon: const Icon(Icons.check_box,
                                    color: Colors.green),
                                disabledIcon: Icon(Icons.lock,
                                    color: Colors.grey.shade300),
                              ),
                              onSelectionChange: controller.onSelectionLocation,
                              itemBuilder: (item, index, onTap) => ListTile(
                                onTap: onTap,
                                style: ListTileStyle.drawer,
                                minTileHeight: 30,
                                title: Text(
                                  item.label,
                                  style: Get.textTheme.bodyMedium?.copyWith(
                                      fontFamily: Fonts.dmSansSemiBold,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                              singleSelect: true,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: isHeightInfinite
                              ? Get.height * .02
                              : height * .02,
                        ),
                        SizedBox(
                          width: Get.width * .95,
                          //height: isHeightInfinite ? null : height * .07,
                          child: Row(
                            children: [
                              AppTextField(
                                width: Get.width * .45,
                                hint: "Vehicle Number",
                                controller: controller.vehicleNumber!,
                                capitalization: TextCapitalization.words,
                                inputAction: TextInputAction.next,
                                keyboardType: TextInputType.streetAddress,
                                prefixIcon: const Icon(
                                  Icons.numbers,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: Get.width * .03,
                              ),
                              AppTextField(
                                hint: "Mobile Number",
                                width: Get.width * .45,
                                controller: controller.mobileNumber!,
                                capitalization: TextCapitalization.words,
                                inputAction: TextInputAction.next,
                                keyboardType: TextInputType.visiblePassword,
                                prefixIcon: const Icon(
                                  Icons.phone_android,
                                  color: Colors.grey,
                                ),
                                autoFocus: false,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: isHeightInfinite
                              ? Get.height * .02
                              : height * .02,
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
                            suggestionDisplayOption: (product) =>
                                product.name ?? "",
                            fieldType: FieldType.autocomplete,
                            autoFocus: false,
                            suggestionConstraints:
                                AppTextField.fixedBoxConstraints(),
                          ),
                        ),
                        SizedBox(
                          height: isHeightInfinite
                              ? Get.height * .02
                              : height * .02,
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
                                          controller.selectedProduct.value !=
                                                  null
                                              ? FieldType.autocomplete
                                              : FieldType.normal,
                                      suggestionConstraints:
                                          AppTextField.fixedBoxConstraints(),
                                      suggestionsBuilder:
                                          controller.findProductPacking,
                                      onSelectResult:
                                          controller.onSelectProductPacking,
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
                                      suggestionsBuilder:
                                          controller.findProductUnit,
                                      onSelectResult:
                                          controller.onSelectProductUnit,
                                      suggestionDisplayOption: (p0) =>
                                          p0.name?.name ?? "None",
                                      fieldType:
                                          controller.selectedProduct.value !=
                                                  null
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
                          height: isHeightInfinite
                              ? Get.height * .02
                              : height * .02,
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
                                  keyboardType: TextInputType.visiblePassword,
                                  prefixIcon: const Icon(
                                    Icons.price_change,
                                    color: Colors.grey,
                                  ),
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
                          height: isHeightInfinite
                              ? Get.height * .02
                              : height * .02,
                        ),
                        SizedBox(
                          width: Get.width * .95,
                          child: Row(
                            children: [
                              Expanded(
                                child: Obx(() => AppButton(
                                      onClick: controller.onSubmitOrder,
                                      height:
                                          isHeightInfinite ? 40 : height * .07,
                                      btnColor: AppColors.buttonColor,
                                      border: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      showLoading:
                                          controller.orderLoading.value,
                                      child: Text(
                                        "SUBMIT ORDER",
                                        style: Get.textTheme.titleLarge
                                            ?.copyWith(
                                                color: Colors.white,
                                                fontFamily:
                                                    Fonts.poppinsMedium),
                                      ).fitBox(),
                                    )),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Obx(() => AppButton(
                                      onClick: controller.addIdWiseQuantities,
                                      height:
                                          isHeightInfinite ? 40 : height * .0,
                                      btnColor: AppColors.buttonColorAlternate,
                                      showLoading:
                                          controller.addItemLoading.value,
                                      border: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Obx(() => Text(
                                            !controller.selectedLocations.every(
                                                    (element) =>
                                                        element.isValid)
                                                ? "Add ITEM NOW"
                                                : "ADD ITEM",
                                            style: Get.textTheme.titleLarge
                                                ?.copyWith(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        Fonts.poppinsMedium),
                                          )),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
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
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Quantity",
                                        style: Get.textTheme.bodySmall
                                            ?.copyWith(
                                                fontFamily: Fonts.poppinsBold),
                                      ),
                                      Text(
                                        "${request.quantity}",
                                        style: Get.textTheme.bodyMedium
                                            ?.copyWith(
                                                fontFamily: Fonts.poppinsBold),
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
                  },
                ))
          ],
        ),
      )),
    );
  }

  @override
  void dispose() {
    Get.delete<CreateCreditOrderScreenController>();
    super.dispose();
  }
}
