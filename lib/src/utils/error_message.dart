import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:future_manager/future_manager.dart';

typedef ResponseMapper = String Function(Map<String, dynamic>?);

class SkadiError {
  ///Get readable error message from various type of exception to display to user
  static String getReadableErrorMessage(
    dynamic exception, {
    ResponseMapper? mapResponseMapper,
  }) {
    String? errorMessage;

    if (exception is FutureManagerError) {
      exception = exception.exception;
    }

    ///Other
    if (exception is PlatformException) {
      errorMessage = exception.message;
    }

    ///Firebase
    else if (exception is FirebaseException) {
      errorMessage = exception.message;
    }

    ////Dio Error
    else if (exception is DioError) {
      ///Socket exception, No internet
      if (exception.error is SocketException) {
        errorMessage = "There is no internet connection!";
      }

      ///Connection timeout
      else if (exception.type == DioErrorType.connectTimeout ||
          exception.type == DioErrorType.receiveTimeout) {
        errorMessage = "Error connecting to server! Connection timeout";
      }

      ///Error with response
      else if (exception.type == DioErrorType.response) {
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

    return errorMessage ?? exception.toString();
  }
}
