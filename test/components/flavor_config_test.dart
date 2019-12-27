import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flavor_banner/components/flavor_config.dart';

void main() {
  group('flavor DEV', () {
    FlavorConfig flavor;

    setUpAll(() {
      // Given
      flavor = FlavorConfig(flavor: Flavor.DEV);
    });

    test('Should return DEV as a name', () {
      expect(flavor.name, 'DEV');
    });

    test('Should return false when checking for production', () {
      expect(flavor.isProduction(), isFalse);
    });

    test('Should return true when checking for Development', () {
      expect(flavor.isDevelopment(), isTrue);
    });

    test('Should return false when checking for QA', () {
      expect(flavor.isQA(), isFalse);
    });
  });

  group('flavor PRODUCTION', () {
    FlavorConfig flavor;

    setUpAll(() {
      // Given
      flavor = FlavorConfig(flavor: Flavor.PRODUCTION);
    });

    test('Should return PRODUCTION as a name', () {
      expect(flavor.name, 'PRODUCTION');
    });

    test('Should return true when checking for production', () {
      expect(flavor.isProduction(), isTrue);
    });

    test('Should return false when checking for Development', () {
      expect(flavor.isDevelopment(), isFalse);
    });

    test('Should return false when checking for QA', () {
      expect(flavor.isQA(), isFalse);
    });
  });


  group('flavor QA', () {
    FlavorConfig flavor;

    setUpAll(() {
      // Given
      flavor = FlavorConfig(flavor: Flavor.QA);
    });

    test('Should return QA as a name', () {
      expect(flavor.name, 'QA');
    });

    test('Should return false when checking for production', () {
      expect(flavor.isProduction(), isFalse);
    });

    test('Should return false when checking for Development', () {
      expect(flavor.isDevelopment(), isFalse);
    });

    test('Should return true when checking for QA', () {
      expect(flavor.isQA(), isTrue);
    });
  });

  test('Should return color green', () {
    // Given
    final flavor = FlavorConfig(
      flavor: Flavor.DEV,
      color: Colors.green,
    );

    // Then
    expect(flavor.color, Colors.green);
  });

  test('Should return color blue', () {
    // Given
    final flavor = FlavorConfig(flavor: Flavor.DEV);

    // Then
    expect(flavor.color, Colors.blue);
  });
}
