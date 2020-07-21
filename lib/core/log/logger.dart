import 'dart:async';

import 'package:f_logs/f_logs.dart';
import 'package:flutter/material.dart';
import 'package:stack_trace/stack_trace.dart';

class Logger {
  Logger._();

  static void initialize() {
    LogsConfig config = FLog.getDefaultConfigurations()
      ..formatType = FormatType.FORMAT_SQUARE
      ..timestampFormat = 'MMMM dd, y - hh:mm:ss a';
    FLog.applyConfigurations(config);
    FlutterError.onError = (FlutterErrorDetails details) async {
      bool inDebugMode = false;
      assert(inDebugMode = true);
      if (inDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      }
      Zone.current.handleUncaughtError(details.exception, details.stack);
    };
  }

  static void info(
    String text, {
    DataLogType type = DataLogType.DEFAULT,
  }) {
    FLog.info(
      text: text,
      dataLogType: type.toString(),
    );
  }

  static void debug(
    String text, {
    DataLogType type = DataLogType.DEFAULT,
  }) {
    FLog.debug(
      text: text,
      dataLogType: type.toString(),
    );
  }

  static void warning(
    String text, {
    DataLogType type = DataLogType.DEFAULT,
  }) {
    FLog.warning(
      text: text,
      dataLogType: type.toString(),
    );
  }

  static void networkError(
    String text,
    Object error, {
    StackTrace trace,
    DataLogType type = DataLogType.DEFAULT,
    String className,
    String methodName,
  }) {
    FLog.error(
      text: text,
      exception: Exception(error.toString()),
    );
  }

  static void error(
    String text,
    Object error,
    StackTrace trace, {
    DataLogType type = DataLogType.DEFAULT,
    String className,
    String methodName,
  }) {
    FLog.error(
      className:
          className ?? Trace.from(trace).frames[1].uri.toString() ?? 'Unknown',
      methodName: methodName ??
          Trace.from(trace).frames[1].member.toString() ??
          'Unknown',
      text: text,
      exception: Exception(error.toString()),
      stacktrace: trace,
      dataLogType: type.toString(),
    );
  }

  static void fatal(
    Object error,
    StackTrace trace, {
    DataLogType type = DataLogType.DEFAULT,
  }) {
    FLog.fatal(
      className: Trace.from(trace).frames[1].uri.toString() ?? 'Unknown',
      methodName: Trace.from(trace).frames[1].member.toString() ?? 'Unknown',
      text: error.toString(),
      exception: Exception(error.toString()),
      stacktrace: trace,
      dataLogType: type.toString(),
    );
  }

  static void exportLogs() {
    FLog.exportLogs();
  }

  static void clearLogs() {
    FLog.clearLogs();
  }
}
