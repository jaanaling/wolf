part of 'user_bloc.dart';

/// Базовый класс состояний
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

/// Состояние загрузки
class UserLoading extends UserState {
  const UserLoading();
}

/// Состояние, когда данные загружены
class UserLoaded extends UserState {
  final User user;
  final List<Articles> articles;
  final List<UActions> actions;

  const UserLoaded({
    required this.user,
    required this.articles,
    required this.actions,
  });

  // Метод copyWith для удобства
  UserLoaded copyWith({
    User? user,
    List<Articles>? articles,
    List<UActions>? actions,
  }) {
    return UserLoaded(
      user: user ?? this.user,
      articles: articles ?? this.articles,
      actions: actions ?? this.actions,
    );
  }

  @override
  List<Object?> get props => [user, articles, actions];
}

/// Состояние ошибки
class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}
