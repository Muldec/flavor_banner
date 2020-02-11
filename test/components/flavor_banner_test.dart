import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flavor_banner/components/device_info_dialog.dart';
import 'package:flavor_banner/components/flavor_config.dart';
import 'package:flavor_banner/components/flavor_banner.dart';

void main() {
  testWidgets(
    'Should fail assertion when child is null', (WidgetTester tester) async {
    // Given
    final widget = () => FlavorBanner(
      child: null,
      flavorConfig: FlavorConfig(
        flavor: Flavor.PRODUCTION,
      ),
    );

    // Then
    expect(widget, throwsAssertionError);
  });

  testWidgets('Should fail assertion when flavorConfig is null', (WidgetTester tester) async {
    // Given
    final widget = () => FlavorBanner(
      child: const Text('Child'),
      flavorConfig: null,
    );

    // Then
    expect(widget, throwsAssertionError);
  });

  testWidgets('Should not display any banner if PRODUCTION', (WidgetTester tester) async {
    // Given
    await tester.pumpWidget(
      MaterialApp(
        home: FlavorBanner(
          child: const Text('Child'),
          flavorConfig: FlavorConfig(
            flavor: Flavor.PRODUCTION,
          ),
        ),
      ),
    );

    // Then
    expect(find.byType(FlavorBannerPaint), findsNothing);
  });

  testWidgets('Should display a banner if QA', (WidgetTester tester) async {
    // Given
    await tester.pumpWidget(
      MaterialApp(
        home: FlavorBanner(
          child: const Text('Child'),
          flavorConfig: FlavorConfig(
            flavor: Flavor.QA,
          ),
        ),
      ),
    );

    // Then
    expect(find.byType(FlavorBannerPaint), findsOneWidget);
  });

  testWidgets('Should display a banner if DEV', (WidgetTester tester) async {
    // Given
    await tester.pumpWidget(
      MaterialApp(
        home: FlavorBanner(
          child: const Text('Child'),
          flavorConfig: FlavorConfig(
            flavor: Flavor.DEV,
          ),
        ),
      ),
    );

    // Then
    expect(find.byType(FlavorBannerPaint), findsOneWidget);
  });

  testWidgets('Should display a DeviceInfoDialog when longPressed', (WidgetTester tester) async {
    // Given
    await tester.pumpWidget(
      MaterialApp(
        home: FlavorBanner(
          child: const Text('Child'),
          flavorConfig: FlavorConfig(
            flavor: Flavor.DEV,
          ),
        ),
      ),
    );

    // When
    await tester.longPress(find.byType(FlavorBannerPaint));

    // Then
    expect(find.byType(DeviceInfoDialog), findsOneWidget);
  });
}
