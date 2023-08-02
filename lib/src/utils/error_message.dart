import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:future_manager/future_manager.dart';

typedef ResponseMapper = String Function(Map<String, dynamic>?);

class SkadiError {
  ///Get readable error message from various type of exception to display to user
  static String getReadableErrorMessage(
    dynamic exception, {
    ///Mapper for Dio error type of Response and Map
    ResponseMapper? mapResponseMapper,
  }) {
    String? errorMessage;

    if (exception is FutureManagerError) {
      exception = exception.exception;
    }

    ///Firebase
    //if (exception is FirebaseException) {
    //   errorMessage = exception.message;
    // }

    ////Dio Error
    if (exception is DioException) {
      ///Socket exception, No internet
      if (exception.type == DioExceptionType.connectionError) {
        errorMessage =
            "Unable to connect to server! Please check your internet connection or Request Url";
      }

      ///Connection timeout
      else if (exception.type == DioExceptionType.connectionTimeout ||
          exception.type == DioExceptionType.receiveTimeout) {
        errorMessage = "Error connecting to server! Connection timeout";
      }

      ///Error with response
      else if (exception.type == DioExceptionType.badResponse) {
        if (mapResponseMapper != null) {
          errorMessage = mapResponseMapper.call(exception.response?.data);
        } else {
          errorMessage = exception.response?.data;
        }
      }

      ///Others
      else {
        errorMessage = exception.message;
      }
    }

    ///Map type
    else if (exception is Map<String, dynamic>) {
      if (mapResponseMapper != null) {
        errorMessage = mapResponseMapper.call(exception);
      }
    }

    ///Argument Error
    else if (exception is ArgumentError) {
      errorMessage = exception.message;
    }

    ///Argument Error
    else if (exception is TypeError) {
      bool nullCheckError = exception.toString().contains("Null");

      ///Null check operator error
      if (nullCheckError) {
        errorMessage = "An unexpected null error occur!";
      } else {
        errorMessage = "An unexpected type error occur!";
      }
    }

    ///Argument Error
    else if (exception is FormatException) {
      errorMessage = "${exception.source}: ${exception.message}";
    }

    ///Http exceptions
    else if (exception is HttpException) {
      errorMessage = exception.message;
    }

    ///FileSystem exception
    else if (exception is FileSystemException) {
      errorMessage = exception.message;
    }

    ///Platform exception
    else if (exception is PlatformException) {
      errorMessage = exception.message;
    }

    return errorMessage ?? exception.toString();
  }
}
