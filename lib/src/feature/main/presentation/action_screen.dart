import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:wolf_survival/src/core/utils/app_icon.dart';
import 'package:wolf_survival/src/core/utils/icon_provider.dart';
import 'package:wolf_survival/src/core/utils/size_utils.dart';
import 'package:wolf_survival/src/core/utils/text_with_border.dart';
import 'package:wolf_survival/src/feature/main/bloc/user_bloc.dart';
import 'package:wolf_survival/src/feature/main/model/actions.dart';
import 'package:wolf_survival/ui_kit/app_app_bar.dart';
import 'package:wolf_survival/ui_kit/app_button.dart';

class ActionScreen extends StatefulWidget {
  const ActionScreen({super.key, required this.action});
  final UActions action;

  @override
  State<ActionScreen> createState() => _ActionScreenState();
}

class _ActionScreenState extends State<ActionScreen> {
  int currentStep = 1;
  int id = 0;
  bool isFinal = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Column(
              children: [
                AppAppBar(title: widget.action.title),
                Gap(16),
             
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    children: [
              
                      ListView.separated(
                        itemCount: widget.action.stages.length,
                        separatorBuilder:
                            (context, index) => const SizedBox(height: 16),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return _buildStepItem(
                            stepNumber: index + 1,
                            text: widget.action.stages[index].title,
                            visible: currentStep - 1 >= index,
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: getHeight(context, percent: 0.3),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              IconProvider.box.buildImageUrl(),
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 4),
                          child: SingleChildScrollView(
                               padding: const EdgeInsets.symmetric(vertical: 30),
                            child: TextWithBorder(
                              widget.action.stages[id].description,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                AppIcon(
                                  asset:
                                      IconProvider.progressBack.buildImageUrl(),
                                  width: getWidth(context, baseSize: 220),
                                  fit: BoxFit.fitWidth,
                                ),
                                if (currentStep < widget.action.stages.length)
                                  Positioned(
                                    left:
                                        -getWidth(context, baseSize: 220) *
                                        (1 -
                                            (currentStep /
                                                widget
                                                    .action
                                                    .stages
                                                    .length)), // Настроить позицию
                                    child: AppIcon(
                                      asset:
                                          IconProvider.progress.buildImageUrl(),
                                      width: getWidth(context, baseSize: 220),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  )
                                else
                                  AppIcon(
                                    asset: IconProvider.progress.buildImageUrl(),
                                    width: getWidth(context, baseSize: 220),
                                    fit: BoxFit.fitWidth,
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          AppButton(
                            text: ">",
                            style: ButtonColors.green,
                            onPressed: () {
                              currentStep++;
                              if (currentStep < widget.action.stages.length + 1) {
                                id++;
                              }
                              setState(() {
                                if (currentStep ==
                                    widget.action.stages.length + 1) {
                                  isFinal = true;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 45),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isFinal) _buildFinalItem(),
      ],
    );
  }

  Widget _buildStepItem({
    required int stepNumber,
    required String text,
    required bool visible,
  }) {
    return Opacity(
      opacity: visible ? 1 : 0,
      child: Row(
        children: [
          AppButton(style: ButtonColors.purple, text: stepNumber.toString()),
          Gap(17),
          Expanded(child: Text(text, style: TextStyle(fontSize: 20))),
        ],
      ),
    );
  }

  Widget _buildFinalItem() {
    return Stack(
      children: [
        Container(
          width: getWidth(context, percent: 1),
          height: getHeight(context, percent: 1),
          decoration: BoxDecoration(color: Color.fromARGB(218, 11, 1, 1)),
        ),
        Positioned(
          bottom: -100,

          child: Image.asset(
            IconProvider.masq.buildImageUrl(),
            width: getWidth(context, percent: 1),
            height: getHeight(context, percent: 1),
          ),
        ),
        Positioned(
          top: 50,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getWidth(context, percent: 0.1),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 23, vertical: 12),
              child: TextWithBorder('Keep it up, cowboy!', fontSize: 60),
            ),
          ),
        ),
        Positioned(
          bottom: 150,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getWidth(context, percent: 0.2),
            ),
            child: AppButton(
              style: ButtonColors.green,
              text: "Yay",
              isRound: false,
              onPressed: () {
                final user =
                    (context.read<UserBloc>().state as UserLoaded).user;
                context.read<UserBloc>().add(
                  UserUpdateData(
                    user.copyWith(
                      comlitedActions: [
                        ...user.comlitedActions,
                        widget.action.id,
                      ],
                    ),
                  ),
                );
                context.pop();
              },
            ),
          ),
        ),
      ],
    );
  }
}
