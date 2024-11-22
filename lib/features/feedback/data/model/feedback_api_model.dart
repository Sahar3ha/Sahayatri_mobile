import 'package:json_annotation/json_annotation.dart';
import 'package:sahayatri/features/feedback/domain/entity/feedback_entity.dart';
part 'feedback_api_model.g.dart';

@JsonSerializable()
class FeedbackApiModel {
  @JsonKey(name: '_id')
  final String? id;
  final String feedback;
  final String? vehicleId;

  FeedbackApiModel({this.id, required this.feedback, this.vehicleId});

  factory FeedbackApiModel.fromJson(Map<String, dynamic> json) =>
      _$FeedbackApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackApiModelToJson(this);

  factory FeedbackApiModel.fromEntity(FeedbackEntity feedbackEntity) {
    return FeedbackApiModel(
        feedback: feedbackEntity.feedback, vehicleId: feedbackEntity.vehicleId);
  }

  static FeedbackEntity toEntity(FeedbackApiModel model) {
    return FeedbackEntity(
        id: model.id, feedback: model.feedback, vehicleId: model.feedback);
  }
}
