import 'package:wolf_survival/routes/route_value.dart';
import 'package:wolf_survival/src/core/utils/app_icon.dart';
import 'package:wolf_survival/src/core/utils/icon_provider.dart';
import 'package:wolf_survival/src/core/utils/size_utils.dart';
import 'package:wolf_survival/src/core/utils/text_with_border.dart';
import 'package:wolf_survival/src/core/utils/animated_button.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wolf_survival/ui_kit/app_button.dart';

class AppAppBar extends StatelessWidget {
  final String? title;

  const AppAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getWidth(context, percent: 1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
        child: Row(
          children: [
            AppButton(
              style: ButtonColors.green,
              text: "<",
              onPressed: () => context.pop(),
            ),
            Spacer(),
            if (title != null)
              Expanded(flex: 5, child: TextWithBorder(title!))
            else
              Row(
                children: [
                  AnimatedButton(
                    onPressed:
                        () => context.push(
                          "${RouteValue.home.path}/${RouteValue.trip.path}/${RouteValue.notes.path}",
                        ),
                    child: AppIcon(asset: IconProvider.notes.buildImageUrl()),
                  ),
                  AnimatedButton(
                    onPressed:
                        () => context.push(
                          "${RouteValue.home.path}/${RouteValue.trip.path}/${RouteValue.resourse.path}",
                        ),
                    child: AppIcon(asset: IconProvider.items.buildImageUrl()),
                  ),
                ],
              ),
            if (title != null) Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
