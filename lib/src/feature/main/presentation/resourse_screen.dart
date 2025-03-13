import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:wolf_survival/main.dart';
import 'package:wolf_survival/routes/route_value.dart';
import 'package:wolf_survival/src/core/utils/icon_provider.dart';
import 'package:wolf_survival/src/core/utils/size_utils.dart';
import 'package:wolf_survival/src/core/utils/text_with_border.dart';
import 'package:wolf_survival/src/feature/main/bloc/user_bloc.dart';
import 'package:wolf_survival/src/feature/main/model/resourse.dart';
import 'package:wolf_survival/ui_kit/app_app_bar.dart';
import 'package:wolf_survival/ui_kit/app_button.dart';
import 'package:wolf_survival/ui_kit/app_text_field.dart';
import 'package:wolf_survival/ui_kit/masq_widget.dart';

class ResourseScreen extends StatefulWidget {
  const ResourseScreen({super.key});

  @override
  State<ResourseScreen> createState() => _ResourseScreenState();
}

class _ResourseScreenState extends State<ResourseScreen> {
  final TextEditingController foodController = TextEditingController();
  final TextEditingController waterController = TextEditingController();
  final List<Resourse> resourses = [];
  String error = "";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return Container();
        }
        final user = state.user;
        if ((user.resourses.isNotEmpty && resourses.isEmpty) ||
            (foodController.text.isEmpty && user.calories != 0) ||
            (waterController.text.isEmpty && user.ml != 0)) {
          foodController.text = user.calories.toString();
          waterController.text = user.ml.toString();
          resourses.addAll(user.resourses);
        }

        return Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  AppAppBar(title: "Your resource"),

                  AppButton(
                    style: ButtonColors.none,
                    isRound: false,
                    child: AppTextField(
                      controller: foodController,
                      title: "Food(Cal.)",
                      keyboardType: TextInputType.number,
                    ),
                    text: "",
                  ),
                  AppButton(
                    style: ButtonColors.none,
                    isRound: false,
                    child: AppTextField(
                      controller: waterController,
                      title: "Water (ml.)",
                      keyboardType: TextInputType.number,
                    ),
                    text: "",
                  ),
                  AppButton(
                    style: ButtonColors.purple,
                    isRound: false,
                    text: 'Resourse',
                    onPressed: () {
                      _showAlertDialog(context, resourses);
                    },
                  ),
                  Gap(15),
                    if (error.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextWithBorder(error, fontSize: 32, color: Colors.red, textAlign: TextAlign.center,),
                    ),
                  Spacer(),
                  AppButton(
                    onPressed: () {
                      if (foodController.text.isEmpty ||
                          waterController.text.isEmpty) {
                        setState(() {
                          error = "Have you decided to go bare-footed?";
                        });
                        return;
                      }
                      setState(() {
                        error = "";
                      });

                      final updateUser = user.copyWith(
                        calories:
                            foodController.text.isEmpty
                                ? 0
                                : double.parse(foodController.text),
                        ml:
                            waterController.text.isEmpty
                                ? 0
                                : double.parse(waterController.text),
                        resourses: resourses,
                        isTourStart: true,
                      );

                      context.read<UserBloc>().add(UserUpdateData(updateUser));
                      context.pushReplacement(
                        "${RouteValue.home.path}/${RouteValue.trip.path}",
                      );
                    },
                    style: ButtonColors.green,
                    isRound: false,
                    text: user.isTourStart ? 'Next' : 'Start Tour',
                    width: getWidth(context, baseSize: 320),
                  ),
                ],
              ),
            ),
            if (!isResourse)
              MaskWidhget(
                screen: Screen.Resourse,
                setState:
                    () => setState(() {
                      isResourse = true;
                    }),
              ),
          ],
        );
      },
    );
  }
}

void _showAlertDialog(BuildContext context, List<Resourse> resourses) {
  final TextEditingController controller = TextEditingController();
  List<Resourse> resoursesList = resourses;

  showDialog(
    context: context,
    useSafeArea: false,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: StatefulBuilder(
          builder:
              (context, StateSetter setState) => SafeArea(
                bottom: false,
                child: Container(
                  width: getWidth(context, percent: 0.95),
                  height: getHeight(context, percent: 0.5),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(IconProvider.box.buildImageUrl()),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          AppButton(
                            width: getWidth(context, percent: 0.65),
                            height: getHeight(context, baseSize: 110),

                            isRound: false,
                            style: ButtonColors.purple,
                            text: "",
                            child: Center(
                              child: AppTextField(
                                controller: controller,
                                keyboardType: TextInputType.text,
                                title: "Resourse",
                              ),
                            ),
                          ),
                          const Spacer(),
                          AppButton(
                            style: ButtonColors.green,
                            width: getWidth(context, baseSize: 60),
                            height: getWidth(context, baseSize: 60),

                            text: "+",
                            onPressed: () {
                              setState(() {
                                if (controller.text.isEmpty) {
                                  return;
                                }
                                final user =
                                    (context.read<UserBloc>().state
                                            as UserLoaded)
                                        .user;
                                resoursesList.add(
                                  Resourse(
                                    id: DateTime.now().millisecondsSinceEpoch,
                                    name: controller.text,
                                  ),
                                );
                                context.read<UserBloc>().add(
                                  UserUpdateData(
                                    user.copyWith(resourses: resoursesList),
                                  ),
                                );
                                controller.clear();
                              });
                            },
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemCount: resoursesList.length,
                          shrinkWrap: true,

                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: TextWithBorder(
                                    resoursesList[index].name,
                                    fontSize: 32,
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: AppButton(
                                    style: ButtonColors.red,
                                    text: "-",
                                    width: getWidth(context, baseSize: 61),
                                    height: getWidth(context, baseSize: 61),
                                    onPressed: () {
                                      setState(() {
                                        resoursesList.removeAt(index);
                                        context.read<UserBloc>().add(
                                          UserUpdateData(
                                            (context.read<UserBloc>().state
                                                    as UserLoaded)
                                                .user
                                                .copyWith(
                                                  resourses: resoursesList,
                                                ),
                                          ),
                                        );
                                      });
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder:
                              (BuildContext context, int indexF) =>
                                  const Gap(10),
                        ),
                      ),

                      AppButton(
                        style: ButtonColors.green,
                        text: "Close",
                        isRound: false,

                        onPressed: () {
                          context.pop();
                        },
                      ),
                    ],
                  ),
                ),
              ),
        ),
      );
    },
  );
}
