import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimatedProgress {
  AnimatedProgress._();

  static bool _isShowing = false;

  static void showProgressIfNot(
      {bool showBlur = false, bool showBarrier = true}) {
    if (Get.overlayContext != null && !(Get.isDialogOpen == true)) {
      _isShowing = true;
      Get.dialog(
        showBlur
            ? BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Dialog(
                    insetPadding: EdgeInsets.all(Get.width * .30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: PopScope(
                      canPop: false,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: const Color(0xFF19333d), width: 1)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Loading..",
                                style: Get.textTheme.titleMedium,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.redAccent,
                                  strokeCap: StrokeCap.round,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
              )
            : Dialog(
                insetPadding: EdgeInsets.all(Get.width * .30),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: PopScope(
                  canPop: false,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: const Color(0xFF19333d), width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Loading..",
                            style: Get.textTheme.titleMedium,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              color: Colors.redAccent,
                              strokeCap: StrokeCap.round,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
        barrierColor: showBarrier ? Colors.black38 : Colors.transparent,
      );
    }
  }

  static void closeProgressIfShowing() {
    if (Get.isDialogOpen == true &&
        Get.overlayContext != null &&
        Get.isOverlaysOpen &&
        _isShowing) {
      _isShowing = false;
      Navigator.of(Get.overlayContext!).pop();
    }
  }
}
