import 'dart:developer';

import 'package:dio/src/options.dart';
import 'package:retrofit/retrofit.dart';

class ServiceErrorLogger extends ParseErrorLogger {
  @override
  void logError(Object? error, StackTrace? stackTrace, RequestOptions options) {
    log('--- Retrofit Error Log ---');

    if (error != null) {
      log('ERROR_REQUEST_OPTIONS: ${options.data}\t${options.uri.toString()}\t${options.queryParameters}\nERROR: $error');
    }

    if (stackTrace != null) {
      log('ERROR_REQUEST_OPTIONS: ${options.data}\t${options.uri.toString()}\t${options.queryParameters}\nSTACKTRACE: $stackTrace');
    }

    log('-------------------------');
  }
}
