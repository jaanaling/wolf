part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class UserLoadData extends UserEvent {
  const UserLoadData();
}

class UserUpdateData extends UserEvent {
  final User user;

  const UserUpdateData(this.user);

  @override
  List<Object?> get props => [user];
}
