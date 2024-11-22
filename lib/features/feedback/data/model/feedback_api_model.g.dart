// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackApiModel _$FeedbackApiModelFromJson(Map<String, dynamic> json) =>
    FeedbackApiModel(
      id: json['_id'] as String?,
      feedback: json['feedback'] as String,
      vehicleId: json['vehicleId'] as String?,
    );

Map<String, dynamic> _$FeedbackApiModelToJson(FeedbackApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'feedback': instance.feedback,
      'vehicleId': instance.vehicleId,
    };
