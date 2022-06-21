import 'package:flutter/material.dart';
import 'package:commune_app/app/shared/tool/constants.dart';
import 'package:commune_app/app/shared/tool/sizes.dart';

class SectionTitle extends StatelessWidget {

  final String title;
  final bool hasAction;
  final Widget? action;
  final bool divider;

  const SectionTitle({
    Key? key,
    required this.title,
    this.hasAction = false,
    this.action,
    this.divider = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.defaultPadding,
                    right: SizeConfig.defaultPadding,
                    top: SizeConfig.defaultPadding / 2,
                    bottom: 10
                ),
                child: Container(
                  // width: double.infinity,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: getPropScreenWidth(18),
                      fontWeight: FontWeight.bold,
                      color: themeColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
            hasAction ? action! : Container(),
          ],
        ),
        Visibility(
          visible: divider,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.defaultPadding,
            ),
            child: Container(
              width: double.infinity,
              height: 2,
              color: themeColors.textSecondary.withOpacity(0.1),
            ),
          ),
        )
      ],
    );
  }
}