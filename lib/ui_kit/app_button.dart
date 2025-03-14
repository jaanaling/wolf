import 'package:flutter/cupertino.dart';
import 'package:wolf_survival/src/core/utils/icon_provider.dart';
import 'package:wolf_survival/src/core/utils/size_utils.dart';
import 'package:wolf_survival/src/core/utils/animated_button.dart';
import 'package:wolf_survival/src/core/utils/text_with_border.dart';

class AppButton extends StatelessWidget {
  final ButtonColors style;
  final bool isRound;
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final Widget? child;

  const AppButton({
    super.key,
    required this.style,
    this.isRound = true,
    required this.text,
    this.onPressed,
    this.width,
    this.height,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      onPressed: onPressed,
      child: Container(
        width:
            width ??
            (isRound
                ? 72
                : getWidth(context, baseSize: 292)),
        height:
            height ??
            (isRound
                ? 72
                : style.colors != null
                ? getHeight(context, baseSize: 73)
                : getHeight(context, baseSize: 104)),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              isRound
                  ? IconProvider.rbutton.buildImageUrl()
                  : IconProvider.button.buildImageUrl(),
            ),
            fit: BoxFit.fill,
          ),
        ),

        child: Padding(
          padding: EdgeInsets.all(isRound ? 10 : 14),
          child:
              
              (style.colors != null
                  ? Container(
                    decoration: ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: style.colors!,
                      ),
                      shape:
                          isRound
                              ? OvalBorder()
                              : RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),

                      shadows: [
                        BoxShadow(
                          color: Color(0xFFFFBE52),
                          blurRadius: 0,
                          offset: Offset(0, 2),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Center(
                      child:child ?? TextWithBorder(text, fontSize: isRound ? 36 : 29),
                    ),
                  )
                  : Center(
                    child:child ?? TextWithBorder(text, textAlign: TextAlign.center),
                  )),
        ),
      ),
    );
  }
}

enum ButtonColors {
  green([Color(0xFFBCD122), Color(0xFF739632)]),
  purple([Color(0xFF7622D1), Color(0xFF323B96)]),
  none(null),
  red([Color(0xFFD13C22), Color(0xFF963232)]);

  final List<Color>? colors;

  const ButtonColors(this.colors);
}
