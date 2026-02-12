import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../colors.dart';
import '../dimensions.dart';
import '../styles.dart';
import 'custom_button.dart';

Widget Common_Pop_Up(
  BuildContext context, {
  required void Function()? BackonPress,
  required void Function()? SaveonPress,
  required String? PopUpDescription,
  required String? backText,
  required String? confirmText,
}) {
  return AlertDialog(
    surfaceTintColor: Colors.white,
    content: Container(
      color: Colors.white,
      width: 350,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(PopUpDescription ?? "",
                style: JosefinSansMedium.copyWith(
                    fontSize: Dimensions.fontSizeLarge),
                textAlign: TextAlign.center),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: BackonPress,
                  child: Container(
                    height: 50,
                    width: MediaQuery.sizeOf(context).width / 3.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: buttonColor),
                    child: Center(
                      child: Text(
                        backText ?? "",
                        textAlign: TextAlign.center,
                        style: JosefinSansBold.copyWith(color: buttonTextColor),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: SaveonPress,
                  child: Container(
                    height: 50,
                    width: MediaQuery.sizeOf(context).width / 3.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: buttonColor),
                    child: Center(
                      child: Text(
                        confirmText ?? "",
                        textAlign: TextAlign.center,
                        style: JosefinSansBold.copyWith(color: buttonTextColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget Single_Common_PopUp(
  BuildContext context, {
  required void Function()? BackonPress,
  required String? PopUpDescription,
  required String? backText,
}) {
  return AlertDialog(
    surfaceTintColor: Colors.white,
    content: Container(
      color: Colors.white,
      width: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(PopUpDescription ?? "",
                style: JosefinSansMedium.copyWith(
                    fontSize: Dimensions.fontSizeLarge),
                textAlign: TextAlign.center),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: InkWell(
              onTap: BackonPress,
              child: Container(
                height: 50,
                width: MediaQuery.sizeOf(context).width / 3.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: buttonColor),
                child: Center(
                  child: Text(
                    backText ?? "",
                    textAlign: TextAlign.center,
                    style: JosefinSansBold.copyWith(color: buttonTextColor),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

void dateConfirmationPop(BuildContext context,
    {required Function()? onPressed}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.info_outline,
                  color: buttonTextColor,
                  size: 30,
                )
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                    child: Text(
                  'better_earning'.tr,
                  textAlign: TextAlign.center,
                ))
              ],
            ),
            actions: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, // Distribute buttons evenly
                children: [
                  CustomButton(
                    width: 90,
                    onPressed: onPressed,
                    buttonText: 'continue'.tr,
                  ),
                  const SizedBox(
                      width: 10), // Add space between buttons if needed
                  CustomButton(
                    width: 130,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    buttonText: 'Back_Calendar'.tr,
                  ),
                ],
              ),
            ],
          );
        },
      );
    },
  );
}
