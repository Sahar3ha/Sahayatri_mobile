import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/features/feedback/domain/entity/feedback_entity.dart';
import 'package:sahayatri/features/feedback/domain/usecase/add_feedback_usecase.dart';
import 'package:sahayatri/features/feedback/presentation/state/feedback_state.dart';

final feedbackViewModelProvider =
    StateNotifierProvider<FeedbackViewModel, FeedbackState>((ref) {
  return FeedbackViewModel(addFeedbackUseCase: ref.read(addFeedbackUseCaseProvider));
});

class FeedbackViewModel extends StateNotifier<FeedbackState> {
  final AddFeedbackUseCase addFeedbackUseCase;

  FeedbackViewModel({
    required this.addFeedbackUseCase,
  }) : super(FeedbackState.initialState());

  void addFeedback(FeedbackEntity feedbackEntity) {
    state = state.copyWith(isLoading: true);
    addFeedbackUseCase.addFeedback(feedbackEntity).then((value) {
      value.fold((failure) => state = state.copyWith(isLoading: false),
          (success) {
        state = state.copyWith(isLoading: false, showMessage: true);
      });
    });
  }

  void resetMessage(bool value) {
    state = state.copyWith(showMessage: value);
  }
}
