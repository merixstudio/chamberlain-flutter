import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_error.freezed.dart';

@freezed
class AppError with _$AppError implements Exception {
  AppError._();

  factory AppError.networkFailure() = _NetworkError;
  factory AppError.serverFailure({
    required int? statusCode,
    required Map<String, dynamic>? json,
  }) = _ServerError;
  factory AppError.unknownFailure(dynamic error) = _UnknownError;

  @override
  String toString() {
    return 'Use localizedTitle or localizedContent methods instead of toString()';
  }

  String localizedTitle(BuildContext context) {
    return when(
      networkFailure: () => '', // AppLoc.of(context).appErrorNetworkTitle,
      serverFailure: (_, __) => '', // AppLoc.of(context).appErrorServerTitle,
      unknownFailure: (_) => '', // AppLoc.of(context).appErrorUnknownTitle,
    );
  }

  String localizedMessage(BuildContext context) {
    return when(
      networkFailure: () => '', //AppLoc.of(context).appErrorNetworkMessage,
      serverFailure: (statusCode, json) {
        return ''; // AppLoc.of(context).appErrorServerMessage(statusCode.toString(), json.toString());
      },
      unknownFailure: (error) => error.toString(),
    );
  }
}
