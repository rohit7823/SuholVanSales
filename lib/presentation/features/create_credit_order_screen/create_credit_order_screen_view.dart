import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/app/theme/colors.dart';
import 'package:suhol_van_sales/app/theme/fonts.dart';
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
                        SizedBox(
                          width: context.width * .95,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: ObxValue(
                                        (locations) => SizedBox(
                                              height: 35,
                                              child: ListView.separated(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount: locations.length,
                                                separatorBuilder:
                                                    (context, index) =>
                                                        const SizedBox(
                                                  width: 5,
                                                ),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) =>
                                                    Chip(
                                                  label: Text(
                                                    "${locations[index].location?.location}",
                                                  ),
                                                  labelStyle: Get
                                                      .textTheme.bodySmall
                                                      ?.copyWith(
                                                          fontSize: 12,
                                                          fontFamily: Fonts
                                                              .poppinsSemiBold),
                                                  avatar: const Icon(
                                                    Icons.location_on_sharp,
                                                    size: 18,
                                                    color: Colors.blueAccent,
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  labelPadding:
                                                      const EdgeInsets.only(
                                                          right: 5),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  deleteIcon: const Icon(
                                                    Icons.close,
                                                    size: 18,
                                                  ),
                                                  deleteButtonTooltipMessage:
                                                      "Remove this location",
                                                  deleteIconColor: Colors.grey,
                                                  onDeleted: () =>
                                                      controller.removeLocation(
                                                          locations[index]),
                                                ),
                                              ).fadedH,
                                            ),
                                        controller.selectedLocations),
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
                                              onTap: controller
                                                  .onClickSendCustomerLocation,
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
                              ObxValue(
                                  (locations) => SizedBox(
                                        height: 35,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            locations.isEmpty
                                                ? Expanded(
                                                    child: Text(
                                                    "Removed locations will show here..",
                                                    style: Get
                                                        .textTheme.bodySmall
                                                        ?.copyWith(
                                                            fontSize: 10,
                                                            fontFamily: Fonts
                                                                .poppinsSemiBold),
                                                  ))
                                                : Expanded(
                                                    child: ListView.separated(
                                                      physics:
                                                          const BouncingScrollPhysics(),
                                                      itemCount:
                                                          locations.length,
                                                      separatorBuilder:
                                                          (context, index) =>
                                                              const SizedBox(
                                                        width: 5,
                                                      ),
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemBuilder:
                                                          (context, index) =>
                                                              Chip(
                                                        label: Text(
                                                          "${locations[index].location?.location}",
                                                        ),
                                                        labelStyle: Get
                                                            .textTheme.bodySmall
                                                            ?.copyWith(
                                                                fontSize: 12,
                                                                fontFamily: Fonts
                                                                    .poppinsSemiBold),
                                                        avatar: const Icon(
                                                          Icons
                                                              .location_off_sharp,
                                                          size: 18,
                                                          color: Colors.grey,
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        labelPadding:
                                                            const EdgeInsets
                                                                .only(right: 5),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                        deleteIcon: const Icon(
                                                          Icons.add,
                                                          size: 18,
                                                        ),
                                                        deleteButtonTooltipMessage:
                                                            "Add this location",
                                                        deleteIconColor:
                                                            Colors.grey,
                                                        onDeleted: () =>
                                                            controller.reAdd(
                                                                locations[
                                                                    index]),
                                                        backgroundColor: Colors
                                                            .redAccent
                                                            .withAlpha(30),
                                                      ),
                                                    ).fadedH,
                                                  ),
                                            TextButton(
                                                onPressed:
                                                    controller.expandLocations,
                                                child: Text(
                                                  "Expand",
                                                  style: Get
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                          color: AppColors
                                                              .buttonColorAlternate,
                                                          fontFamily:
                                                              Fonts.dmSansBold),
                                                ))
                                          ],
                                        ),
                                      ),
                                  controller.removedLocations)
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
                                      onClick: controller.onAddItem,
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
      )) /*Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
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
                                        searchController:
                                            controller.customerName!,
                                        capitalization:
                                            TextCapitalization.words,
                                        inputAction: TextInputAction.next,
                                        suggestionsBuilder:
                                            controller.findCustomerName,
                                        onSelectResult:
                                            controller.onSelectCustomer,
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
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
                              SizedBox(
                                width: context.width * .95,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: AppTextField(
                                            hint: "Location",
                                            width: Get.width * .45,
                                            fieldType: FieldType.normal,
                                            controller:
                                                controller.customerLocation!,
                                            capitalization:
                                                TextCapitalization.words,
                                            inputAction: TextInputAction.next,
                                            prefixIcon: const Icon(
                                              Icons.location_on_sharp,
                                              color: Colors.grey,
                                            ),
                                            autoFocus: false,
                                            onChanged: (input) {
                                              if (input != null) {
                                                controller
                                                    .onLocationChanged(input);
                                              }
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: ColoredBox(
                                              color: AppColors
                                                  .buttonColorAlternate,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: InkWell(
                                                    onTap: controller
                                                        .onClickSendCustomerLocation,
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
                                    ObxValue(
                                        (locations) => locations.isEmpty
                                            ? const SizedBox.shrink()
                                            : SizedBox(
                                                height: 35,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: ListView.separated(
                                                        physics:
                                                            const BouncingScrollPhysics(),
                                                        itemCount:
                                                            locations.length,
                                                        separatorBuilder:
                                                            (context, index) =>
                                                                const SizedBox(
                                                          width: 5,
                                                        ),
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemBuilder:
                                                            (context, index) =>
                                                                Chip(
                                                          label: Text(
                                                            "${locations[index].location?.location}",
                                                          ),
                                                          labelStyle: Get
                                                              .textTheme
                                                              .bodySmall
                                                              ?.copyWith(
                                                                  fontSize: 12,
                                                                  fontFamily: Fonts
                                                                      .poppinsSemiBold),
                                                          avatar: const Icon(
                                                            Icons
                                                                .location_on_sharp,
                                                            size: 18,
                                                            color: Colors
                                                                .blueAccent,
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          labelPadding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 5),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          deleteIcon:
                                                              const Icon(
                                                            Icons.close,
                                                            size: 18,
                                                          ),
                                                          deleteButtonTooltipMessage:
                                                              "Remove this location",
                                                          deleteIconColor:
                                                              Colors.grey,
                                                          onDeleted: () =>
                                                              controller
                                                                  .removeLocation(
                                                                      locations[
                                                                          index]),
                                                        ),
                                                      ).fadedH,
                                                    ),
                                                    TextButton(
                                                        onPressed: controller
                                                            .expandLocations,
                                                        child: Text(
                                                          "Expand",
                                                          style: Get.textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                                  color: AppColors
                                                                      .buttonColorAlternate,
                                                                  fontFamily: Fonts
                                                                      .dmSansBold),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                        controller.selectedLocations)
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
                                      keyboardType:
                                          TextInputType.visiblePassword,
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
                                  suggestionsBuilder:
                                      controller.findProductName,
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
                                            searchController:
                                                controller.packing!,
                                            capitalization:
                                                TextCapitalization.words,
                                            inputAction: TextInputAction.next,
                                            prefixIcon: const Icon(
                                              Icons.backpack,
                                              color: Colors.grey,
                                            ),
                                            fieldType: controller
                                                        .selectedProduct
                                                        .value !=
                                                    null
                                                ? FieldType.autocomplete
                                                : FieldType.normal,
                                            suggestionConstraints: AppTextField
                                                .fixedBoxConstraints(),
                                            suggestionsBuilder:
                                                controller.findProductPacking,
                                            onSelectResult: controller
                                                .onSelectProductPacking,
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
                                            fieldType: controller
                                                        .selectedProduct
                                                        .value !=
                                                    null
                                                ? FieldType.autocomplete
                                                : FieldType.normal,
                                            suggestionConstraints: AppTextField
                                                .fixedBoxConstraints(),
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
                                        capitalization:
                                            TextCapitalization.words,
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
                                            onClick: controller.onAddItem,
                                            height: isHeightInfinite
                                                ? 40
                                                : height * .0,
                                            btnColor:
                                                AppColors.buttonColorAlternate,
                                            showLoading:
                                                controller.addItemLoading.value,
                                            border: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Obx(() => Text(
                                                  !controller.selectedLocations
                                                          .every((element) =>
                                                              element.isValid)
                                                      ? "Add ITEM NOW"
                                                      : "ADD ITEM",
                                                  style: Get
                                                      .textTheme.titleLarge
                                                      ?.copyWith(
                                                          color: Colors.white,
                                                          fontFamily: Fonts
                                                              .poppinsMedium),
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
                        itemCount: controller.addedMaterialRequests.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var request = controller.addedMaterialRequests[index];
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
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text.rich(TextSpan(
                                                text: "Customer ID: ",
                                                style: Get.textTheme.bodySmall,
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        "${request.customerId}",
                                                    style: Get
                                                        .textTheme.bodySmall
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  )
                                                ])),
                                            Text.rich(TextSpan(
                                                text: "Product ID: ",
                                                style: Get.textTheme.bodySmall,
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        "${request.productId}",
                                                    style: Get
                                                        .textTheme.bodySmall
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  )
                                                ])),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text.rich(TextSpan(
                                                text:
                                                    "Unit of Measurement ID: ",
                                                style: Get.textTheme.bodySmall,
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        "${request.unitOfMeasurementId}",
                                                    style: Get
                                                        .textTheme.bodySmall
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  )
                                                ])),
                                            Text.rich(TextSpan(
                                                text: "Packing ID: ",
                                                style: Get.textTheme.bodySmall,
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        "${request.packingId}",
                                                    style: Get
                                                        .textTheme.bodySmall
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  )
                                                ])),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  const Divider(),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text.rich(TextSpan(
                                        text: "Delivery Date: ",
                                        style: Get.textTheme.bodySmall,
                                        children: [
                                          TextSpan(
                                            text: DateFormat('yyyy-MM-dd')
                                                .format(request.deliveryDate ??
                                                    DateTime.now()),
                                            style: Get.textTheme.bodySmall
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          )
                                        ])),
                                  ),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Parent Master ID(s): ",
                                          style: Get.textTheme.bodySmall,
                                        ),
                                      ),
                                      Row(
                                        children:
                                            request.locationIdsWithQuantity
                                                    ?.map(
                                                      (e) => Text.rich(TextSpan(
                                                        text: "ID: ",
                                                        style: Get.textTheme
                                                            .bodySmall,
                                                        children: [
                                                          TextSpan(
                                                            text: "${e.id}",
                                                            style: Get.textTheme
                                                                .bodySmall
                                                                ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                          const TextSpan(
                                                              text: " | "),
                                                          TextSpan(
                                                              text:
                                                                  "Quantity: ",
                                                              style: Get
                                                                  .textTheme
                                                                  .bodySmall,
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      "${e.qty}${e != request.locationIdsWithQuantity?.last ? ', ' : ''}",
                                                                  style: Get
                                                                      .textTheme
                                                                      .bodySmall
                                                                      ?.copyWith(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                )
                                                              ])
                                                        ],
                                                      )),
                                                    )
                                                    .toList() ??
                                                [],
                                      )
                                    ],
                                  ),
                                  const Divider(),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text.rich(TextSpan(
                                        text: "Remarks: ",
                                        style: Get.textTheme.bodySmall,
                                        children: [
                                          TextSpan(
                                            text: "${request.remarks}",
                                            style: Get.textTheme.bodySmall
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          )
                                        ])),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ))
                ],
              ),
            ),
          ),
          BudgetWidget(
              items: controller.addedMaterialRequests,
              vat: controller.vat,
              total: controller.total)
        ],
      ))*/
      ,
    );
  }

  @override
  void dispose() {
    Get.delete<CreateCreditOrderScreenController>();
    super.dispose();
  }
}
