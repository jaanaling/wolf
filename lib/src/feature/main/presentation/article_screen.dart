import 'package:flutter/cupertino.dart';
import 'package:wolf_survival/src/core/utils/icon_provider.dart';
import 'package:wolf_survival/src/core/utils/size_utils.dart';
import 'package:wolf_survival/src/core/utils/text_with_border.dart';
import 'package:wolf_survival/src/feature/main/model/articles.dart';
import 'package:wolf_survival/ui_kit/app_app_bar.dart';

class ArticleScreen extends StatelessWidget {
  final Articles article;

  const ArticleScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          AppAppBar(title: article.title),
          Container(
            width: getWidth(context, percent: 0.8),
            height: getHeight(context, percent: 0.8),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(IconProvider.window.buildImageUrl()),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0,16),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 60,
                  ),
                  child: TextWithBorder(article.description),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
