import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wolf_survival/routes/route_value.dart';
import 'package:wolf_survival/src/feature/main/bloc/user_bloc.dart';
import 'package:wolf_survival/ui_kit/app_app_bar.dart';
import 'package:wolf_survival/ui_kit/app_button.dart';
import 'package:gap/gap.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return Container();
        }
        return SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                AppAppBar(title: "Survivalist’s Diary"),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder:
                      (context, index) => AppButton(
                        onPressed:
                            () => context.push(
                              "${RouteValue.home.path}/${RouteValue.diary.path}/${RouteValue.article.path}",
                              extra: state.articles[index],
                            ),
                        style: ButtonColors.none,
                        text: state.articles[index].title,
                        isRound: false,
                      ),
                  separatorBuilder: (_, __) => Gap(7),
                  itemCount: state.articles.length,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
