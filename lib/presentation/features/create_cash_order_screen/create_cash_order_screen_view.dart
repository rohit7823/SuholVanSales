import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/app/theme/images.dart';
import 'package:suhol_van_sales/presentation/utils/extensions.dart';
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
                KeyboardAwareWidgetTwo(child: (context, height, isHeightInfinite) => Column(
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
                              controller: controller.email!,
                              capitalization: TextCapitalization.words,
                              keyboardType: TextInputType.emailAddress,
                              inputAction: TextInputAction.next,
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
                                          .onClickSendEmail,
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
                    SizedBox(height: isHeightInfinite ? Get.height * .02 : height * .02,),
                    SizedBox(
                      width: Get.width * .95,
                      height: isHeightInfinite ? null : height * .07,
                      child: AppTextField(
                        hint: "Customer Name",
                        controller: controller.customerName!,
                        capitalization: TextCapitalization.words,
                        inputAction: TextInputAction.next,
                      ),
                    ),
                    SizedBox(height: isHeightInfinite ? Get.height * .02 : height * .02,),
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
                            inputFormatters: [NumberTextInputFormatter()],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: isHeightInfinite ? Get.height * .02 : height * .02,),
                    SizedBox(
                      height: isHeightInfinite ? null : height * .07,
                      child: AppTextField(
                        hint: "Product Name",
                        width: Get.width * .95,
                        controller: controller.productName!,
                        capitalization: TextCapitalization.words,
                        inputAction: TextInputAction.next,
                      ),
                    ),
                    SizedBox(height: isHeightInfinite ? Get.height * .02 : height * .02,),
                    SizedBox(
                      width: Get.width * .95,
                      height: isHeightInfinite ? null : height * .07,
                      child: Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              hint: "Packing",
                              controller: controller.packing!,
                              capitalization: TextCapitalization.words,
                              inputAction: TextInputAction.next,
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: AppTextField(
                              hint: "Unit",
                              controller: controller.unit!,
                              inputAction: TextInputAction.next,
                            ),
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
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: isHeightInfinite ? Get.height * .02 : height * .02,),
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
                              keyboardType: TextInputType.visiblePassword,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 2,
                            child: AppTextField(
                              hint: "Remarks",
                              controller: controller.remarks!,
                              inputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              capitalization: TextCapitalization.words,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: isHeightInfinite ? Get.height * .02 : height * .02,),
                    SizedBox(
                      width: Get.width * .95,
                      child: Row(
                        children: [
                          Expanded(
                            child: AppButton(
                              onClick: controller.onSubmitOrder,
                              height: isHeightInfinite
                                  ? 40
                                  : height * .07,
                              btnColor: AppColors.buttonColor,
                              border: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                "Submit Order",
                                style: Get.textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                    fontFamily: Fonts.poppinsMedium),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: AppButton(
                              onClick: controller.onAddItem,
                              height: isHeightInfinite
                                  ? 40
                                  : height * .07,
                              btnColor: AppColors.buttonColorAlternate,
                              border: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                "Add Item",
                                style: Get.textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                    fontFamily: Fonts.poppinsMedium),
                              ),
                            ),
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
