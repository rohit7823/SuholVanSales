import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retrofit/http.dart';
import 'package:suhol_van_sales/presentation/widgets/app_text_field.dart';
import 'package:suhol_van_sales/presentation/widgets/keyboard_aware_widget_two.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/fonts.dart';
import '../../utils/number_text_input_formatter.dart';
import '../../widgets/app_button.dart';
import '../../widgets/budget_widget.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/user_info.dart';
import 'create_cash_order_screen_controller.dart';

class CreateCashOrderScreen extends StatefulWidget {
  const CreateCashOrderScreen({super.key});

  @override
  State<CreateCashOrderScreen> createState() => _CreateCashOrderScreenState();
}

class _CreateCashOrderScreenState extends State<CreateCashOrderScreen> {
  final controller = Get.find<CreateCashOrderScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        leadingWidth: 12,
        title: UserInfo(
            userName: controller.userName, shopName: controller.shopName),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: ColoredBox(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          InkWell(
                              onTap: controller.pop,
                              child: const Icon(
                                Icons.arrow_back_sharp,
                                color: Colors.grey,
                              )),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            "Create Cash Sales Order",
                            style: Get.textTheme.titleMedium?.copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                KeyboardAwareWidgetTwo(
                    child: (context, height, isHeightInfinite) => Column(
                          children: [
                            SizedBox(
                              width: Get.width * .95,
                              height: isHeightInfinite ? null : height * .07,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: AppTextField(
                                      hint: "Customer email",
                                      width: Get.width * .45,
                                      isFullScreen: true,
                                      fieldType: FieldType.autocomplete,
                                      searchController: controller.email!,
                                      capitalization: TextCapitalization.words,
                                      keyboardType: TextInputType.emailAddress,
                                      inputAction: TextInputAction.next,
                                      suggestionsBuilder:
                                          controller.findCustomerEmail,
                                      onSelectResult:
                                          controller.onSelectCustomerEmail,
                                      suggestionDisplayOption: (customer) =>
                                          customer.email ?? "",
                                      suggestionConstraints: BoxConstraints(
                                          maxHeight: (height * .35)),
                                      prefixIcon: const Icon(
                                        Icons.email,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: ColoredBox(
                                        color: AppColors.buttonColorAlternate,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: InkWell(
                                              onTap:
                                                  controller.onClickSendEmail,
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
                            SizedBox(
                              width: Get.width * .95,
                              height: isHeightInfinite ? null : height * .07,
                              child: AppTextField(
                                hint: "Customer Name",
                                width: Get.width * .45,
                                isFullScreen: true,
                                fieldType: FieldType.autocomplete,
                                searchController: controller.customerName!,
                                capitalization: TextCapitalization.words,
                                inputAction: TextInputAction.next,
                                suggestionsBuilder: controller.findCustomerName,
                                onSelectResult: controller.onSelectCustomer,
                                suggestionDisplayOption: (customer) =>
                                    customer.name ?? "",
                                suggestionConstraints:
                                    BoxConstraints(maxHeight: (height * .35)),
                                prefixIcon: const Icon(
                                  Icons.person_2,
                                  color: Colors.grey,
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
                              height: isHeightInfinite ? null : height * .07,
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
                                    inputFormatters: [
                                      NumberTextInputFormatter()
                                    ],
                                    prefixIcon: const Icon(
                                      Icons.phone_android,
                                      color: Colors.grey,
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
                              height: isHeightInfinite ? null : height * .07,
                              child: AppTextField(
                                hint: "Product Name",
                                width: Get.width * .95,
                                isFullScreen: true,
                                fieldType: FieldType.autocomplete,
                                searchController: controller.productName!,
                                capitalization: TextCapitalization.words,
                                inputAction: TextInputAction.next,
                                prefixIcon: const Icon(
                                  Icons.production_quantity_limits,
                                  color: Colors.grey,
                                ),
                                suggestionsBuilder: controller.findProductName,
                                onSelectResult: controller.onSelectProduct,
                                suggestionDisplayOption: (product) =>
                                    product.name ?? "",
                                suggestionConstraints:
                                    BoxConstraints(maxHeight: (height * .35)),
                              ),
                            ),
                            SizedBox(
                              height: isHeightInfinite
                                  ? Get.height * .02
                                  : height * .02,
                            ),
                            SizedBox(
                              width: Get.width * .95,
                              height: isHeightInfinite ? null : height * .07,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Obx(() => AppTextField(
                                          hint: "Packing",
                                          searchController: controller.packing!,
                                          capitalization:
                                              TextCapitalization.words,
                                          inputAction: TextInputAction.next,
                                          prefixIcon: const Icon(
                                            Icons.backpack,
                                            color: Colors.grey,
                                          ),
                                          fieldType: controller
                                                      .selectedProduct.value !=
                                                  null
                                              ? FieldType.autocomplete
                                              : FieldType.normal,
                                          suggestionConstraints: BoxConstraints(
                                              maxHeight: (height * .35)),
                                          suggestionsBuilder:
                                              controller.findProductPacking,
                                          onSelectResult:
                                              controller.onSelectProductPacking,
                                          suggestionDisplayOption: (p0) =>
                                              p0.packing ?? "None",
                                          isFullScreen: true,
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
                                          isFullScreen: true,
                                          fieldType: controller
                                                      .selectedProduct.value !=
                                                  null
                                              ? FieldType.autocomplete
                                              : FieldType.normal,
                                          capitalization:
                                              TextCapitalization.words,
                                          suggestionConstraints: BoxConstraints(
                                              maxHeight: (height * .35)),
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
                              height: isHeightInfinite ? null : height * .07,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: AppTextField(
                                      hint: "Price",
                                      controller: controller.price!,
                                      inputAction: TextInputAction.next,
                                      keyboardType:
                                          TextInputType.visiblePassword,
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
                                          height: isHeightInfinite
                                              ? 40
                                              : height * .07,
                                          btnColor: AppColors.buttonColor,
                                          border: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          showLoading:
                                              controller.orderLoading.value,
                                          child: Text(
                                            "Submit Order",
                                            style: Get.textTheme.titleLarge
                                                ?.copyWith(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        Fonts.poppinsMedium),
                                          ),
                                        )),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Obx(() => AppButton(
                                          onClick: controller.onAddItem,
                                          height: isHeightInfinite
                                              ? 40
                                              : height * .07,
                                          btnColor:
                                              AppColors.buttonColorAlternate,
                                          border: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          showLoading:
                                              controller.addItemLoading.value,
                                          child: Text(
                                            "Add Item",
                                            style: Get.textTheme.titleLarge
                                                ?.copyWith(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        Fonts.poppinsMedium),
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            )
                          ],
                        )),
              ],
            ),
          )),
          BudgetWidget(
              items: controller.items,
              vat: controller.vat,
              total: controller.total)
        ],
      )),
    );
  }

  @override
  void dispose() {
    Get.delete<CreateCashOrderScreenController>();
    super.dispose();
  }
}
