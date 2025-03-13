import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:wolf_survival/main.dart';
import 'package:wolf_survival/src/core/utils/icon_provider.dart';
import 'package:wolf_survival/src/core/utils/size_utils.dart';
import 'package:wolf_survival/src/core/utils/text_with_border.dart';
import 'package:wolf_survival/src/feature/main/model/calculator.dart';
import 'package:wolf_survival/ui_kit/app_app_bar.dart';
import 'package:wolf_survival/ui_kit/app_button.dart';
import 'package:wolf_survival/ui_kit/app_text_field.dart';
import 'package:wolf_survival/ui_kit/masq_widget.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController daysController = TextEditingController();
  final TextEditingController peopleController = TextEditingController();
  String place = Calculator.places()[0];
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Column(
            children: [
              AppAppBar(title: "Calculator"),
              CountTextField(
                controller: daysController,
                title: "days",
                setState: () => setState(() {}),
              ),
              CountTextField(
                controller: peopleController,
                title: "people",
                setState: () => setState(() {}),
              ),
              AppButton(
                style: ButtonColors.none,
                isRound: false,
                text: place,
                width: getWidth(context, baseSize: 204),
                onPressed: () {
                  _showAlertDialog(context, Calculator.places(), (index) {
                    setState(() {
                      place = Calculator.places()[index];
                    });
                  });
                },
              ),
              Gap(10),
              if (error.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextWithBorder(error, fontSize: 32, color: Colors.red, textAlign: TextAlign.center,),
                ),

              Spacer(),
              AppButton(
                onPressed: () {
                  if (daysController.text.isEmpty ||
                      peopleController.text.isEmpty ||
                      int.parse(daysController.text) <= 0 ||
                      int.parse(peopleController.text) <= 0) {
                    setState(() {
                      error =
                          "I won't be able to count anything if you don't enter anything.";
                    });
                    return;
                  }
                  setState(() {
                    error = "";
                  });

                  final calculator = Calculator(
                    days: int.parse(daysController.text),
                    people: int.parse(peopleController.text),
                    place: place,
                  );

                  _showCalculateDialog(
                    context,
                    calculator.calculateSurvivalNeeds(),
                  );
                },
                style: ButtonColors.green,
                isRound: false,
                text: 'Calculate',
                width: getWidth(context, baseSize: 320),
              ),
            ],
          ),
        ),
        if (!isCalculator)
          MaskWidhget(
            screen: Screen.Calculator,
            setState:
                () => setState(() {
                  isCalculator = true;
                }),
          ),
      ],
    );
  }
}

void _showAlertDialog(
  BuildContext context,
  List<String> places,
  Function(int index) onSelectedItemChanged,
) {
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
                  width: getWidth(context, percent: 0.5),
                  height: 400,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(IconProvider.box.buildImageUrl()),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: CupertinoPicker.builder(
                          itemExtent: 40,
                          onSelectedItemChanged: onSelectedItemChanged,
                          childCount: places.length,
                          itemBuilder: (context, index) {
                            return Center(
                              child: TextWithBorder(
                                places[index],
                                fontSize: 20,
                              ),
                            );
                          },
                        ),
                      ),
                      const Spacer(),
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

void _showCalculateDialog(
  BuildContext context,
  Map<String, dynamic> calculator,
) {
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 1),
                    Container(
                      width: getWidth(context, percent: 0.8),
                      height: getHeight(context, percent: 0.5),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(IconProvider.box.buildImageUrl()),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextWithBorder(
                              "Water: ${calculator['waterMl']} ml",
                              fontSize: 20,
                            ),
                            TextWithBorder(
                              "Food: ${calculator['foodCalories']} cal",
                              fontSize: 20,
                            ),
                            Gap(10),
                            TextWithBorder("items", fontSize: 23),
                            ListView.separated(
                              itemCount:
                                  (calculator['items'] as List<String>).length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return TextWithBorder(
                                  calculator['items'][index] as String,
                                  fontSize: 20,
                                  textAlign: TextAlign.center,
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int indexF) =>
                                      const SizedBox(height: 10),
                            ),
                          ],
                        ),
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
      );
    },
  );
}
