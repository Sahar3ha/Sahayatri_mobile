
import 'package:sahayatri/features/auth/domain/entity/user_entity.dart';

class FeedbackState {
  final bool isLoading;
  final String? error;
  final List<UserEntity> users;
  final bool? showMessage;

  FeedbackState(
      {required this.isLoading,
      this.error,
      required this.users,
      this.showMessage});

  factory FeedbackState.initialState() =>
      FeedbackState(isLoading: false,error: null, users: [], showMessage: false);

  FeedbackState copyWith({
    bool? isLoading,
    String? error,
    List<UserEntity>? users,
    bool? showMessage,
  }) {
    return FeedbackState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,

        users: users ?? this.users,
        showMessage: showMessage ?? this.showMessage);
  }
}
