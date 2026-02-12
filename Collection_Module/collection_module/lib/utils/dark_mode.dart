import 'styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'core/theme/controller/theme_controller.dart';
import 'dimensions.dart';
import 'images.dart';

class DarkMode extends StatefulWidget {
  const DarkMode({super.key});

  @override
  State<DarkMode> createState() => _LanguageChangeState();
}

class _LanguageChangeState extends State<DarkMode> {
  bool? value = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (controller) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(Dimensions.radiusExtraLarge),
          ),
          color: Theme.of(context).cardColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault,
                  vertical: Dimensions.paddingSizeDefault),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'change_theme'.tr,
                    style: JosefinSansSemiBold.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontSize: Dimensions.fontSizeDefault),
                  ),
                  InkWell(
                    onTap: () => Get.back(),
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    child: Padding(
                      padding: const EdgeInsets.all(
                          Dimensions.paddingSizeExtraSmall),
                      child: SvgPicture.asset(
                        Images.cancel,
                        height: Dimensions.paddingSizeSmall,
                        width: Dimensions.paddingSizeSmall,
                        color: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .color!
                            .withOpacity(0.6),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        Images.theme,
                        height: 16,
                        width: 16,
                        color: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .color!
                            .withOpacity(0.6),
                      ),
                      const SizedBox(
                        width: Dimensions.paddingSizeDefault,
                      ),
                      Text('dark_mode'.tr,
                          style: JosefinRegular.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color!,
                              fontSize: Dimensions.fontSizeSmall)),
                    ],
                  ),
                  FlutterSwitch(
                    width: 40,
                    height: 20,
                    valueFontSize: 20,
                    toggleSize: 20,
                    borderRadius: 30,
                    padding: 1.0,
                    showOnOff: false,
                    toggleColor: Colors.white,
                    activeColor: Colors.green,
                    inactiveColor: Colors.grey,
                    value: controller.darkTheme,
                    onToggle: (value) {
                      controller.toggleTheme();
                      Get.back();
                    },
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      );
    });
  }
}
