import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reimburse_rb/utility/constant.dart';

/// Prefer size 95
class AppBarGeneral extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final Function()? onBack;
  final Function()? titleOnTap;
  final String title;
  final String? customImage;
  final double? imageWidth;
  final Alignment imageAligment;
  final bool lightenImage;
  final double height;
  final double bottomBorderRadiusSize;
  final List<Widget> actions;
  final bool automaticallyImplyLeading;
  final bool isHasCustomLeading;
  final Color backgroundColor;
  final Color? appBarColor;
  final Color titleColor;
  final Widget? titleReplacementWidget;
  final Icon leadingIcon;
  final PreferredSizeWidget? bottomWidget;

  const AppBarGeneral({
    required this.context,
    this.titleOnTap,
    this.titleColor = Colors.white,
    this.title = '',
    this.onBack,
    this.actions = const [],
    this.automaticallyImplyLeading = false,
    this.isHasCustomLeading = true,
    this.backgroundColor = Colors.transparent,
    this.appBarColor,
    this.height = 95,
    this.customImage,
    this.imageWidth,
    this.lightenImage = false,
    this.imageAligment = Alignment.center,
    this.titleReplacementWidget,
    this.bottomBorderRadiusSize = 24,
    this.leadingIcon = const Icon(
      Icons.arrow_back_ios_new_rounded,
      color: Colors.white,
    ),
    this.bottomWidget,
    super.key,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // elevation: 4,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: backgroundColor,
      toolbarHeight: height,
      bottom: bottomWidget,
      flexibleSpace: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(bottomBorderRadiusSize),
          bottomRight: Radius.circular(bottomBorderRadiusSize),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: appBarColor,
            gradient: appBarColor == null
                ? LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topRight,
                    colors: [
                      Constant.greenDark,
                      Constant.green.withOpacity(0.9),
                    ],
                  )
                : null,
          ),
          child: Stack(
            children: [
              customImage == null || customImage == ''
                  ? Container()
                  : Align(
                      alignment: imageAligment,
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        width: imageWidth ?? (MediaQuery.of(context).size.width * 0.5),
                        child: lightenImage
                            ? ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  Colors.white.withOpacity(0.5),
                                  BlendMode.dstIn,
                                ),
                                child: Image.asset(
                                  customImage ??
                                      'assets/apps_logo/logo-horizontal-white-reimburserb.png',
                                  fit: BoxFit.cover,
                                  alignment: Alignment.bottomCenter,
                                  color: Colors.white,
                                ),
                              )
                            : Image.asset(
                                customImage ??
                                    'assets/apps_logo/logo-horizontal-white-reimburserb.png',
                                fit: BoxFit.cover,
                                alignment: Alignment.bottomCenter,
                              ),
                      ),
                    ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 38, 24, 8),
                  child: Row(
                    mainAxisAlignment: actions.isNotEmpty
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            if (isHasCustomLeading)
                              InkWell(
                                onTap: onBack ??
                                    () {
                                      Navigator.of(context).pop();
                                    },
                                child: leadingIcon,
                              ),
                            const SizedBox(width: 16),
                            Flexible(
                              child: titleReplacementWidget ??
                                  InkWell(
                                    onTap: titleOnTap,
                                    child: Text(
                                      title,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        color: titleColor,
                                        fontSize: 20,
                                        fontWeight: Constant.mediumWeightText,
                                      ),
                                    ),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 12),
                        child: Row(
                          children: actions,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
