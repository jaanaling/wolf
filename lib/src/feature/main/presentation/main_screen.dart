import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:wolf_survival/main.dart';
import 'package:wolf_survival/routes/route_value.dart';
import 'package:wolf_survival/src/core/utils/app_icon.dart';
import 'package:wolf_survival/src/core/utils/icon_provider.dart';
import 'package:wolf_survival/src/core/utils/size_utils.dart';
import 'package:wolf_survival/src/feature/main/bloc/user_bloc.dart';
import 'package:wolf_survival/ui_kit/app_button.dart';
import 'package:wolf_survival/ui_kit/masq_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return Container();
        }
        return Stack(
          children: [
            SafeArea(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getWidth(context, baseSize: 42),
                    ),
                    child: Row(
                      children: [
                        AppIcon(asset: IconProvider.chain.buildImageUrl()),
                        Spacer(),
                        AppIcon(asset: IconProvider.chain.buildImageUrl()),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 80),
                            child: AppIcon(
                              asset: IconProvider.masq2.buildImageUrl(),
                              fit: BoxFit.cover,
                            ),
                          ),
                          AppIcon(asset: IconProvider.logo.buildImageUrl()),
                        ],
                      ),
                      AppButton(
                        style: ButtonColors.green,
                        text: "Survival Calculator",
                        isRound: false,
                        onPressed:
                            () => context.push(
                              "${RouteValue.home.path}/${RouteValue.calculator.path}",
                            ),
                      ),
                      AppButton(
                        style: ButtonColors.red,
                        isRound: false,
                        text: "Dangerous Trip",
                        onPressed:
                            () => context.push(
                              state.user.isTourStart
                                  ? "${RouteValue.home.path}/${RouteValue.trip.path}"
                                  : "${RouteValue.home.path}/${RouteValue.resourse.path}",
                            ),
                      ),
                      AppButton(
                        style: ButtonColors.purple,
                        isRound: false,
                        text: "Survivalist’s Diary",
                        onPressed:
                            () => context.push(
                              "${RouteValue.home.path}/${RouteValue.diary.path}",
                            ),
                      ),
                      Gap(getWidth(context, baseSize: 150)),
                    ],
                  ),
                ],
              ),
            ),
            if (!isHome)
              MaskWidhget(
                screen: Screen.Home,
                setState:
                    () => setState(() {
                      isHome = true;
                    }),
              ),
          ],
        );
      },
    );
  }
}
