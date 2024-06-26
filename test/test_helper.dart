import 'dart:io';

import 'package:flutter/cupertino.dart';

void ignoreOverflowErrors(
    FlutterErrorDetails details, {
      bool forceReport = false,
    }) {
  bool ifIsOverflowError = false;
  bool isUnableToLoadAsset = false;// Detect overflow error.
  var exception = details.exception;
  if (exception is FlutterError) {
    ifIsOverflowError = !exception.diagnostics.any(
          (e) => e.value.toString().startsWith("A RenderFlex overflowed by"),
    );
    isUnableToLoadAsset = !exception.diagnostics.any(
          (e) => e.value.toString().startsWith("Unable to load asset"),
    );
  }// Ignore if is overflow error.
  if (ifIsOverflowError || isUnableToLoadAsset) {
    //debugPrint('Ignored Error');
    return;
  } else {
    FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
    exit(1);
  }
  //exit(1);
}