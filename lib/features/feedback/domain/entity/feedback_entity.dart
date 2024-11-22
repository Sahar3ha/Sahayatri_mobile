import 'package:equatable/equatable.dart';

class FeedbackEntity extends Equatable {
  final String? id;
  final String feedback;
  final String? vehicleId;

  const FeedbackEntity({this.id, required this.feedback, this.vehicleId});

  @override
  List<Object?> get props => [id, feedback, vehicleId];

  factory FeedbackEntity.fromJson(Map<String, dynamic> json) => FeedbackEntity(
      id: json['id'], feedback: json['feedback'], vehicleId: json['vehicleId']);

  Map<String, dynamic> toJson() =>
      {"id": id, "feedback": feedback, "vehicleId": vehicleId};

  @override
  String toString() {
    return 'FeedbackEntity(id: $id, feedback: $feedback,vehicleId: $vehicleId)';
  }
}
