import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../../../core/app_themes.dart';

class SideMenuItem extends StatelessWidget {
  const SideMenuItem({
    Key? key,
    this.isActive,
    this.isHover = false,
    this.itemCount,
    this.showBorder = true,
    required this.icon,
    required this.title,
    required this.press,
  }) : super(key: key);

  final bool? isActive, isHover, showBorder;
  final int? itemCount;
  final String title;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: InkWell(
        onTap: press,
        child: Row(
          children: [
            (isActive! || isHover!)
                ? WebsafeSvg.asset(
                    "assets/icons/Angle right.svg",
                    width: 15,
                  )
                : SizedBox(width: 15),
            SizedBox(width: kDefaultPadding / 4),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(bottom: 15, right: 5),
                decoration: showBorder!
                    ? BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Color(0xFFDFE2EF)),
                        ),
                      )
                    : null,
                child: Row(
                  children: [
                    Icon(
                      icon,
                      size: 20,
                      color:
                          (isActive! || isHover!) ? primaryColor : kGrayColor,
                    ),
                    SizedBox(width: kDefaultPadding * 0.75),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: (isActive! || isHover!)
                                ? kTextColor
                                : kGrayColor,
                          ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
