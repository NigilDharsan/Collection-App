import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors.dart';
import '../core/helper/route_helper.dart';
import '../dimensions.dart';
import '../styles.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isBackButtonExist;
  final Function()? onBackPressed;
  final bool? showCart;
  final bool? isLogin;
  final bool? centerTitle;
  final Color? bgColor;
  final Color? titleColor;
  final List<Widget>? actions;
  const CustomAppBar(
      {super.key,
      this.title = '',
      this.isLogin = false,
      this.isBackButtonExist = true,
      this.onBackPressed,
      this.showCart = false,
      this.centerTitle = false,
      this.bgColor,
      this.titleColor,
      this.actions = const [SizedBox()]});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title!,
        style: order_style2,
      ),
      centerTitle: centerTitle,
      automaticallyImplyLeading: true,
      titleSpacing: isBackButtonExist ? 5 : 10,
      leading: isBackButtonExist
          ? IconButton(
              splashRadius: Dimensions.paddingSizeLarge,
              hoverColor: Colors.transparent,
              icon: Icon(Icons.arrow_back_ios,
                  color: titleColor ?? Theme.of(context).primaryColor),
              color: brandGreyColor,
              onPressed: () => (isLogin != null && isLogin!)
                  ? Get.offAllNamed(RouteHelper.onBoardScreen)
                  : onBackPressed != null
                      ? onBackPressed!()
                      : Navigator.pop(context),
            )
          : null,
      backgroundColor: bgColor,
      elevation: 0,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(Dimensions.preferredSize);
}
