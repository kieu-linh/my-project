import 'package:flutter/material.dart';
import 'package:my_project/constants/app_colors.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final Color? backgroundColor;
  final Color? titleColor;

  const AppAppBar({
    Key? key,
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    this.showBackButton = true,
    this.backgroundColor,
    this.titleColor,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0.5,
      centerTitle: true,
      leading: showBackButton
          ? leading ??
              (Navigator.canPop(context)
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back_ios,
                          color: AppColors.greyDark),
                      onPressed: () => Navigator.pop(context),
                    )
                  : null)
          : leading,
      title: titleWidget ??
          (title != null
              ? Text(
                  title!,
                  style: TextStyle(
                    color: titleColor ?? AppColors.greyDark,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null),
      actions: actions,
    );
  }
}
