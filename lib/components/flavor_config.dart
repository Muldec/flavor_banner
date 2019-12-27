import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flavor_banner/services/string_utils.dart';

/// All the flavors available to build the application
enum Flavor {
  DEV, // ignore: constant_identifier_names, public_member_api_docs
  QA, // ignore: constant_identifier_names, public_member_api_docs
  PRODUCTION, // ignore: constant_identifier_names, public_member_api_docs
}

class FlavorConfig {
  /// [Flavor] of the application
  final Flavor flavor;

  /// [Color] to visually identify the [flavor] from the app UI
  final Color color;

  /// Instantiates the singleton by providing members values
  FlavorConfig({
    @required this.flavor,
    this.color = Colors.blue,
  });

  /// Gets the string value of the [flavor]
  String get name => StringUtils.enumName(flavor);

  /// Returns `true` only if the [flavor] is [Flavor.PRODUCTION]
  bool isProduction() => flavor == Flavor.PRODUCTION;

  /// Returns `true` only if the [flavor] is [Flavor.DEV]
  bool isDevelopment() => flavor == Flavor.DEV;

  /// Returns `true` only if the [flavor] is [Flavor.QA]
  bool isQA() => flavor == Flavor.QA;
}
