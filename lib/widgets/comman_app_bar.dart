import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleKey;
  final bool showBack;
  final List<Widget>? actions;
  final Widget? titleWidget;
  final double? leadingWidth;
  final double? iconPaddingFromLeft;
  final double circularRadius;
  final bool centerTitle;
  final void Function()? onBackPressed;

  const CommonAppBar({
    required this.titleKey,
    this.showBack = true,
    this.actions,
    this.leadingWidth,
    this.circularRadius=16,
    this.iconPaddingFromLeft,
    super.key,
    this.titleWidget,
    this.centerTitle = true,
    this.onBackPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,

      leading: showBack
          ? Padding(
        padding: EdgeInsets.only(left: iconPaddingFromLeft ?? 0.0),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: onBackPressed ?? () => Navigator.of(context).maybePop(),
        ),
      )
          : Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.white, size: 24),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),

      leadingWidth: leadingWidth,
      title: titleWidget ??
          Text(
            titleKey,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
      centerTitle: centerTitle,
      actions: actions,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(circularRadius),
        ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              appColors.gradientSecondColor,
              appColors.primaryColor,
              appColors.primaryColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(circularRadius),
          ),
        ),
      ),
    );


  }
}
