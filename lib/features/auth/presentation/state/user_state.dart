
import 'package:sahayatri/features/auth/domain/entity/user_entity.dart';

class UserState {
  final bool isLoading;
  final String? error;
  final List<UserEntity> users;
  final bool? showMessage;

  UserState(
      {required this.isLoading,
      this.error,
      required this.users,
      this.showMessage});

  factory UserState.initialState() =>
      UserState(isLoading: false,error: null, users: [], showMessage: false);

  UserState copyWith({
    bool? isLoading,
    String? error,
    List<UserEntity>? users,
    bool? showMessage,
  }) {
    return UserState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,

        users: users ?? this.users,
        showMessage: showMessage ?? this.showMessage);
  }
}
