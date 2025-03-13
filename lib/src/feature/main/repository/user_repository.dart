import 'package:flutter/cupertino.dart';
import 'package:wolf_survival/src/feature/main/model/actions.dart';
import 'package:wolf_survival/src/feature/main/model/articles.dart';

import 'package:wolf_survival/src/feature/main/model/user.dart';

import '../../../core/utils/json_loader.dart';

class Repository {
  final String articles = 'articles';
  final String user = 'user';
  final String actions = "actions";

  Future<List<User>> load() {
    return JsonLoader.loadData<User>(
      user,
      'assets/json/$user.json',
      (json) => User.fromMap(json),
    );
  }

  Future<List<Articles>> loadArticles() {
    return JsonLoader.loadData<Articles>(
      articles,
      'assets/json/$articles.json',
      (json) => Articles.fromMap(json),
    );
  }

  Future<List<UActions>> loadActions() {
    return JsonLoader.loadData<UActions>(
      actions,
      'assets/json/$actions.json',
      (json) => UActions.fromMap(json),
    );
  }

  Future<void> save(User item) {
    return JsonLoader.saveData<User>(
      user,
      item,
      () async => await load(),
      (item) => item.toMap(),
    );
  }

  Future<void> update(User updated) async {
    return await JsonLoader.modifyDataList<User>(
      user,
      updated,
      () async => await load(),
      (item) => item.toMap(),
      (itemList) async {
        final index = 0;
        if (index != -1) {
          itemList[index] = updated;
        }
      },
    );
  }
}
