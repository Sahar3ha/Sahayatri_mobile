import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/config/routes/app_routes.dart';
import 'package:sahayatri/features/auth/domain/use_case/user_login_use_case.dart';
import 'package:sahayatri/features/auth/presentation/state/user_state.dart';

final loginViewModelProvider =
    StateNotifierProvider.autoDispose<LoginViewModel, UserState>(
        (ref) => LoginViewModel(ref.read(userLoginUseCaseProvider)));

class LoginViewModel extends StateNotifier<UserState> {
  final LoginUseCase loginUseCase;

  LoginViewModel(this.loginUseCase) : super(UserState.initialState());
  Future<void> loginUser(
      BuildContext context, String email, String password) async {
    state = state.copyWith(isLoading: true);
    final result = await loginUseCase.loginUser(email, password);
    state = state.copyWith(isLoading: false);
    result.fold(
      (failure) => state = state.copyWith(
        error: failure.error,
        showMessage: true,
      ),
      (success) {
        state = state.copyWith(
          isLoading: false,
          showMessage: true,
          error: null,
        );
        Navigator.pushNamed(context, AppRoute.dashboard);
      },
    );
  }


  void reset() {
    state = state.copyWith(
      isLoading: false,
      error: null,
      showMessage: false,
    );
  }

  void resetMessage() {
    state = state.copyWith(showMessage: false, error: null, isLoading: false);
  }
}
