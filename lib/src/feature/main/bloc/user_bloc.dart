import 'package:bloc/bloc.dart';
import 'package:wolf_survival/src/feature/main/model/actions.dart';
import 'package:wolf_survival/src/feature/main/model/articles.dart';
import 'package:equatable/equatable.dart';
import 'package:wolf_survival/src/core/dependency_injection.dart';
import 'package:wolf_survival/src/feature/main/model/user.dart';
import 'package:wolf_survival/src/feature/main/repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final Repository userRepository = locator<Repository>();

  UserBloc() : super(const UserLoading()) {
    on<UserLoadData>(_onUserLoadData);
    on<UserUpdateData>(_onUserUpdateData);
  }

  Future<void> _onUserLoadData(
    UserLoadData event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());
    try {
      // Репозиторий возвращает список пользователей; берём первого или init
      final users = await userRepository.load();
      User user = users.isNotEmpty ? users.first : User.init();
      final actions = await userRepository.loadActions();

      if (users.isEmpty) {
        userRepository.save(user);
      }

      final articles = await userRepository.loadArticles();

      emit(UserLoaded(user: user, articles: articles, actions: actions));
    } catch (e) {
      emit(UserError('Произошла ошибка при загрузке: $e'));
    }
  }

  Future<void> _onUserUpdateData(
    UserUpdateData event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());
    try {
      await userRepository.update(event.user);

      final user = await userRepository.load();
      final actions = await userRepository.loadActions();
      final articles = await userRepository.loadArticles();

      emit(UserLoaded(user: user.first, actions: actions, articles: articles));
    } catch (e) {
      emit(UserError('Произошла ошибка при обновлении данных: $e'));
    }
  }
}
