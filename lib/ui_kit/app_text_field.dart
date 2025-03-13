import 'package:gap/gap.dart';
import 'package:wolf_survival/src/core/utils/app_icon.dart';
import 'package:wolf_survival/src/core/utils/icon_provider.dart';
import 'package:wolf_survival/src/core/utils/size_utils.dart';
import 'package:wolf_survival/src/core/utils/animated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wolf_survival/src/core/utils/text_with_border.dart';
import 'package:wolf_survival/ui_kit/app_button.dart';

class CountTextField extends StatelessWidget {
  const CountTextField({
    super.key,
    required this.controller,
    required this.title,
    this.keyboardType = TextInputType.number,
    required this.setState,
  });

  final TextEditingController controller;
  final String title;
  final TextInputType? keyboardType;
  final VoidCallback setState;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppButton(
            style: ButtonColors.red,
            text: "-",
            onPressed: () {
              if (controller.text.isNotEmpty) {
                controller.text = (int.parse(controller.text) - 1).toString();
              } else {
                controller.text = "0";
              }
              setState();
            },
          ),
          SizedBox(
            width: getWidth(context, baseSize: 149),
            child: AppTextField(
              controller: controller,
              keyboardType: keyboardType,
              title: title,
              backgrund: IconProvider.field.buildImageUrl(),
              flex: 0,
            ),
          ),
          AppButton(
            style: ButtonColors.green,
            text: "+",
            onPressed: () {
              if (controller.text.isNotEmpty) {
                controller.text = (int.parse(controller.text) + 1).toString();
              } else {
                controller.text = "1";
              }
              setState();
            },
          ),
        ],
      ),
    );
  }
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.title,
    this.backgrund,
    this.maxLines,
    this.flex = 1,


  });

  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String title;
  final String? backgrund;
  final int? maxLines;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Column(
          children: [
            Gap(10),
            Expanded(
              flex: 0,
              child: CupertinoTextField(
                controller: controller,
                keyboardType: keyboardType,
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                maxLines: maxLines,
                placeholder: title,
                placeholderStyle:TextStyle(
                  color: Colors.white,
                  fontSize: 29,
              
                  fontFamily: 'Font',
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                padding: EdgeInsets.symmetric(
                  vertical: getWidth(context, baseSize: 18),
                ),
                decoration:
                    backgrund == null
                        ? null
                        : BoxDecoration(
                          image: DecorationImage(image: AssetImage(backgrund!), fit: BoxFit.fill),
                        ),
              ),
            ),
          ],
        ),
        if (controller.text.isNotEmpty) TextWithBorder(title, fontSize: 23),
      ],
    );
  }
}
