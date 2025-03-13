import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:wolf_survival/main.dart';
import 'package:wolf_survival/routes/route_value.dart';
import 'package:wolf_survival/src/core/utils/text_with_border.dart';
import 'package:wolf_survival/src/feature/main/bloc/user_bloc.dart';
import 'package:wolf_survival/ui_kit/app_app_bar.dart';
import 'package:wolf_survival/ui_kit/app_button.dart';
import 'package:wolf_survival/ui_kit/masq_widget.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({super.key});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  int daytime = 1;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return const CupertinoActivityIndicator();
        }
        final actions = state.actions;
        final userEndActions = state.user.comlitedActions;

        return Stack(
          children: [
            SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    AppAppBar(),
                    TextWithBorder("It's been 0 days"),
                    Gap(10),
                    AppButton(
                      onPressed:
                          () => setState(() {
                            if (daytime < 3) {
                              daytime++;
                            } else {
                              daytime = 1;
                            }
                          }),
                      style: ButtonColors.purple,
                      isRound: false,
                      text:
                          daytime == 1
                              ? "Morning"
                              : daytime == 2
                              ? "Day"
                              : "Evening",
                    ),
                    Gap(10),
            
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: actions.where((e) => e.daytime == daytime).length,
                      separatorBuilder: (_, __) => Gap(7),
                      itemBuilder: (context, index) {
                        final action =
                            actions
                                .where((e) => e.daytime == daytime)
                                .toList()[index];
                        final isDone =
                            userEndActions
                                .where((element) => element == action.id)
                                .length;
            
                        return AppButton(
                          onPressed:
                              () => context.push(
                                "${RouteValue.home.path}/${RouteValue.trip.path}/${RouteValue.action.path}",
                                extra: action,
                              ),
                          style: ButtonColors.none,
                          isRound: false,
                          text:
                              "${action.title}${isDone > 0 ? "\ndone $isDone times" : ""}",
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
              if (!isTrip)
              MaskWidhget(
                screen: Screen.Trip,
                setState: () => setState(
                  () {
                    isTrip = true;
                  },
                ),
              )
          ],
        );
      },
    );
  }
}
