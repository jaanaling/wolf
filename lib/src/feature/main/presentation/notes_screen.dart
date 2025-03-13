import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:wolf_survival/main.dart';
import 'package:wolf_survival/src/core/utils/icon_provider.dart';
import 'package:wolf_survival/src/core/utils/size_utils.dart';
import 'package:wolf_survival/src/core/utils/text_with_border.dart';
import 'package:wolf_survival/src/feature/main/bloc/user_bloc.dart';
import 'package:wolf_survival/src/feature/main/model/notes.dart';
import 'package:wolf_survival/ui_kit/app_app_bar.dart';
import 'package:wolf_survival/ui_kit/app_button.dart';
import 'package:wolf_survival/ui_kit/app_text_field.dart';
import 'package:wolf_survival/ui_kit/masq_widget.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return const Center(child: CircularProgressIndicator());
        }
        final user = state.user;
        final notes = user.notes;
        return Stack(
          children: [
            SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    AppAppBar(title: "Notes"),
                    AppButton(
                      style: ButtonColors.purple,
                      text: "Add note",
                      onPressed: () {
                        _showAlertDialog(context);
                      },

                      isRound: false,
                    ),
                    ListView.separated(
                      itemCount: notes.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppButton(
                              style: ButtonColors.none,
                              text: notes[index].text,
                              isRound: false,
                              width: getWidth(context, baseSize: 280),
                            ),
                            const Gap(10),
                            AppButton(
                              style: ButtonColors.red,
                              text: "-",
                              width: getWidth(context, baseSize: 61),
                              height: getWidth(context, baseSize: 61),
                              onPressed: () {
                                final newNotes = [...notes];
                                newNotes.removeAt(index);
                                context.read<UserBloc>().add(
                                  UserUpdateData(
                                    user.copyWith(notes: newNotes),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => Gap(10),
                    ),
                  ],
                ),
              ),
            ),
            if (!isNotes)
              MaskWidhget(
                screen: Screen.Notes,
                setState:
                    () => setState(() {
                      isNotes = true;
                    }),
              ),
          ],
        );
      },
    );
  }
}

void _showAlertDialog(BuildContext context) {
  final TextEditingController controller = TextEditingController();
  String error = "";
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
                  width: getWidth(context, percent: 0.8),
                  height: getHeight(context, percent: 0.6),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(IconProvider.box.buildImageUrl()),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppButton(
                        style: ButtonColors.none,
                        isRound: false,
                        height: getHeight(context, baseSize: 220),
                        child: AppTextField(
                          controller: controller,
                          maxLines: 5,
                          title: "note",
                          keyboardType: TextInputType.number,
                        ),
                        text: "",
                      ),
                      Gap(10),
                      if (error.isNotEmpty)
                      TextWithBorder(error, fontSize: 32, color: Colors.red),
                      Gap(10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppButton(
                            width: getWidth(context, baseSize: 120),
                            style: ButtonColors.red,
                            text: "Cancel",
                            isRound: false,
                            onPressed: () {
                              context.pop();
                            },
                          ),

                          AppButton(
                            style: ButtonColors.green,
                               width: getWidth(context, baseSize: 120),
                            text: "Save",
                            isRound: false,

                            onPressed: () {
                              if (controller.text.isEmpty) {
                                setState(() {
                                  error =
                                      "Hey, have you forgotten how to write?";
                                });
                                return;
                              }

                              final user =
                                  (context.read<UserBloc>().state as UserLoaded)
                                      .user;
                              context.read<UserBloc>().add(
                                UserUpdateData(
                                  user.copyWith(
                                    notes: [
                                      ...user.notes,
                                      Notes(
                                        id:
                                            DateTime.now()
                                                .millisecondsSinceEpoch
                                                .toString(),
                                        text: controller.text,
                                      ),
                                    ],
                                  ),
                                ),
                              );

                              context.pop();
                            },
                          ),
                        ],
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
