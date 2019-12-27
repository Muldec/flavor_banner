import 'package:flutter_test/flutter_test.dart';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:flavor_banner/components/device_info_dialog.dart';
import 'package:flavor_banner/services/build_info.dart';
import 'package:flavor_banner/services/platform_wrapper.dart';

void main() {
  group('check color', () {
    testWidgets('Should find amberAccent in title when color is amberAccent', (
      WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog(
            flavorName: 'FOO',
            color: Colors.amberAccent,
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) {
        if (widget is AlertDialog) {
          final alertDialog = widget;
          final Container title = alertDialog.title;
          final BoxDecoration decoration = title.decoration;
          return decoration.color == Colors.amberAccent;
        }
        return false;
      }), findsOneWidget);
    });

    testWidgets('Should find red in title when color is red', (
      WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog(
            flavorName: 'FOO',
            color: Colors.red,
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) {
        if (widget is AlertDialog) {
          final alertDialog = widget;
          final Container title = alertDialog.title;
          final BoxDecoration decoration = title.decoration;
          return decoration.color == Colors.red;
        }
        return false;
      }), findsOneWidget);
    });
  });

  group('check flavor', () {
    testWidgets('Should find FOO when android and flavor is FOO', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: 'FOO',
            color: Colors.amberAccent,
            platform: FakeAndroidPlatform(),
            deviceInfo: FakeAndroidDeviceInfoPlugin(),
            buildInfo: FakeBuildInfo(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('FOO'), findsOneWidget);
    });

    testWidgets('Should find FLAV when android and flavor is FLAV', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: 'FLAV',
            color: Colors.amberAccent,
            platform: FakeAndroidPlatform(),
            deviceInfo: FakeAndroidDeviceInfoPlugin(),
            buildInfo: FakeBuildInfo(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('FLAV'), findsOneWidget);
    });

    testWidgets('Should find FLAV when ios and flavor is FLAV', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: 'FLAV',
            color: Colors.amberAccent,
            platform: FakeIOSPlatform(),
            deviceInfo: FakeIosDeviceInfoPlugin(),
            buildInfo: FakeBuildInfo(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('FLAV'), findsOneWidget);
    });

    testWidgets('Should find FOO when ios and flavor is FOO', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: 'FOO',
            color: Colors.amberAccent,
            platform: FakeIOSPlatform(),
            deviceInfo: FakeIosDeviceInfoPlugin(),
            buildInfo: FakeBuildInfo(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('FOO'), findsOneWidget);
    });
  });

  group('check device type', () {
    const unknownDevice = 'You\'re neither on Android nor iOS';

    testWidgets('Should display a message when the OS is unknown', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog(
            flavorName: 'FOO',
            color: Colors.amberAccent,
          ),
        ),
      );

      expect(find.text(unknownDevice), findsOneWidget);
    });

    testWidgets('Should not find the unknown device message when android', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: 'FOO',
            color: Colors.amberAccent,
            platform: FakeAndroidPlatform(),
            deviceInfo: FakeAndroidDeviceInfoPlugin(),
            buildInfo: FakeBuildInfo(),
          ),
        ),
      );

      expect(find.text(unknownDevice), findsNothing);
    });

    testWidgets('Should not find the unknown device message when ios', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: 'FOO',
            color: Colors.amberAccent,
            platform: FakeIOSPlatform(),
            deviceInfo: FakeIosDeviceInfoPlugin(),
            buildInfo: FakeBuildInfo(),
          ),
        ),
      );

      expect(find.text(unknownDevice), findsNothing);
    });

    testWidgets('Should find a sizedBox while loading when android', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: 'FOO',
            color: Colors.amberAccent,
            platform: FakeAndroidPlatform(),
            deviceInfo: FakeAndroidDeviceInfoPlugin(),
            buildInfo: FakeBuildInfo(),
          ),
        ),
      );

      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('Should find a sizedBox while loading when ios', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: 'FOO',
            color: Colors.amberAccent,
            platform: FakeIOSPlatform(),
            deviceInfo: FakeIosDeviceInfoPlugin(),
            buildInfo: FakeBuildInfo(),
          ),
        ),
      );

      expect(find.byType(SizedBox), findsOneWidget);
    });
  });

  group('check build mode', () {
    testWidgets('Should find DEBUG when ios and DEBUG mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: "FOO",
            color: Colors.amberAccent,
            platform: FakeIOSPlatform(),
            deviceInfo: FakeIosDeviceInfoPlugin(),
            buildInfo: FakeBuildInfo(buildMode: BuildMode.debug),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('debug'), findsOneWidget);
    });

    testWidgets('Should find PROFILE when ios and PROFILE mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: "FOO",
            color: Colors.amberAccent,
            platform: FakeIOSPlatform(),
            deviceInfo: FakeIosDeviceInfoPlugin(),
            buildInfo: FakeBuildInfo(buildMode: BuildMode.profile),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('profile'), findsOneWidget);
    });

    testWidgets('Should find RELEASE when ios and RELEASE mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: "FOO",
            color: Colors.amberAccent,
            platform: FakeIOSPlatform(),
            deviceInfo: FakeIosDeviceInfoPlugin(),
            buildInfo: FakeBuildInfo(buildMode: BuildMode.release),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('release'), findsOneWidget);
    });

    testWidgets('Should find DEBUG when android and DEBUG mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: "FOO",
            color: Colors.amberAccent,
            platform: FakeAndroidPlatform(),
            deviceInfo: FakeAndroidDeviceInfoPlugin(),
            buildInfo: FakeBuildInfo(buildMode: BuildMode.debug),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('debug'), findsOneWidget);
    });

    testWidgets('Should find PROFILE when android and PROFILE mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: "FOO",
            color: Colors.amberAccent,
            platform: FakeAndroidPlatform(),
            deviceInfo: FakeAndroidDeviceInfoPlugin(),
            buildInfo: FakeBuildInfo(buildMode: BuildMode.profile),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('profile'), findsOneWidget);
    });

    testWidgets('Should find RELEASE when android and RELEASE mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: "FOO",
            color: Colors.amberAccent,
            platform: FakeAndroidPlatform(),
            deviceInfo: FakeAndroidDeviceInfoPlugin(),
            buildInfo: FakeBuildInfo(buildMode: BuildMode.release),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('release'), findsOneWidget);
    });
  });

  group('check physical device', () {
    testWidgets('Should find true when ios and physical device', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: "FOO",
            color: Colors.amberAccent,
            platform: FakeIOSPlatform(),
            deviceInfo: FakeIosDeviceInfoPlugin(isPhysicalDevice: true),
            buildInfo: FakeBuildInfo(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('true'), findsOneWidget);
    });

    testWidgets('Should find true when android and physical device', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: "FOO",
            color: Colors.amberAccent,
            platform: FakeAndroidPlatform(),
            deviceInfo: FakeAndroidDeviceInfoPlugin(isPhysicalDevice: true),
            buildInfo: FakeBuildInfo(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('true'), findsOneWidget);
    });

    testWidgets('Should find false when ios and not physical device', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: "FOO",
            color: Colors.amberAccent,
            platform: FakeIOSPlatform(),
            deviceInfo: FakeIosDeviceInfoPlugin(isPhysicalDevice: false),
            buildInfo: FakeBuildInfo(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('false'), findsOneWidget);
    });

    testWidgets('Should find false when android and not physical device', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: "FOO",
            color: Colors.amberAccent,
            platform: FakeAndroidPlatform(),
            deviceInfo: FakeAndroidDeviceInfoPlugin(isPhysicalDevice: false),
            buildInfo: FakeBuildInfo(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('false'), findsOneWidget);
    });

  });

  group('check model', () {
    testWidgets('Should find Ipad when ios and model Ipad', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: "FOO",
            color: Colors.amberAccent,
            platform: FakeIOSPlatform(),
            deviceInfo: FakeIosDeviceInfoPlugin(model: 'Ipad'),
            buildInfo: FakeBuildInfo(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('Ipad'), findsOneWidget);
    });

    testWidgets('Should find Iphone X when ios and model Iphone X', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: "FOO",
            color: Colors.amberAccent,
            platform: FakeIOSPlatform(),
            deviceInfo: FakeIosDeviceInfoPlugin(model: 'Iphone X'),
            buildInfo: FakeBuildInfo(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('Iphone X'), findsOneWidget);
    });

    testWidgets('Should find Galaxy Tab when android and model Galaxy Tab', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: "FOO",
            color: Colors.amberAccent,
            platform: FakeAndroidPlatform(),
            deviceInfo: FakeAndroidDeviceInfoPlugin(model: 'Galaxy Tab'),
            buildInfo: FakeBuildInfo(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('Galaxy Tab'), findsOneWidget);
    });

    testWidgets('Should find Samsung S7 when android and model Samsung S7', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: "FOO",
            color: Colors.amberAccent,
            platform: FakeAndroidPlatform(),
            deviceInfo: FakeAndroidDeviceInfoPlugin(model: 'Samsung S7'),
            buildInfo: FakeBuildInfo(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('Samsung S7'), findsOneWidget);
    });
  });

  group('check name', () {
    testWidgets('Should find Ipad when ios and name Ipad', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: "FOO",
            color: Colors.amberAccent,
            platform: FakeIOSPlatform(),
            deviceInfo: FakeIosDeviceInfoPlugin(name: 'Ipad'),
            buildInfo: FakeBuildInfo(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('Ipad'), findsOneWidget);
    });

    testWidgets('Should find Iphone X when ios and name Iphone X', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: "FOO",
            color: Colors.amberAccent,
            platform: FakeIOSPlatform(),
            deviceInfo: FakeIosDeviceInfoPlugin(name: 'Iphone X'),
            buildInfo: FakeBuildInfo(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('Iphone X'), findsOneWidget);
    });
  });

  group('check systemName', () {
    testWidgets('Should find Catalina when ios and systemName Catalina', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: "FOO",
            color: Colors.amberAccent,
            platform: FakeIOSPlatform(),
            deviceInfo: FakeIosDeviceInfoPlugin(systemName: 'Catalina'),
            buildInfo: FakeBuildInfo(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('Catalina'), findsOneWidget);
    });

    testWidgets('Should find Leopard when ios and systemName Leopard', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: "FOO",
            color: Colors.amberAccent,
            platform: FakeIOSPlatform(),
            deviceInfo: FakeIosDeviceInfoPlugin(systemName: 'Leopard'),
            buildInfo: FakeBuildInfo(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('Leopard'), findsOneWidget);
    });
  });

  group('check systemVersion', () {
    testWidgets('Should find 13.1 when ios and systemVersion 2.5', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: "FOO",
            color: Colors.amberAccent,
            platform: FakeIOSPlatform(),
            deviceInfo: FakeIosDeviceInfoPlugin(systemName: '13.1'),
            buildInfo: FakeBuildInfo(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('13.1'), findsOneWidget);
    });

    testWidgets('Should find 2.5 when ios and systemVersion 2.5', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: "FOO",
            color: Colors.amberAccent,
            platform: FakeIOSPlatform(),
            deviceInfo: FakeIosDeviceInfoPlugin(systemName: '2.5'),
            buildInfo: FakeBuildInfo(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('2.5'), findsOneWidget);
    });
  });

  group('check manufacturer', () {
    testWidgets('Should find samsung when android and manufacturer samsung', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: "FOO",
            color: Colors.amberAccent,
            platform: FakeAndroidPlatform(),
            deviceInfo: FakeAndroidDeviceInfoPlugin(manufacturer: 'samsung'),
            buildInfo: FakeBuildInfo(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('samsung'), findsOneWidget);
    });

    testWidgets('Should find google when android and manufacturer google', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: "FOO",
            color: Colors.amberAccent,
            platform: FakeAndroidPlatform(),
            deviceInfo: FakeAndroidDeviceInfoPlugin(manufacturer: 'google'),
            buildInfo: FakeBuildInfo(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('google'), findsOneWidget);
    });
  });

  group('check version', () {
    testWidgets('Should find beta when android and version.release beta', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: "FOO",
            color: Colors.amberAccent,
            platform: FakeAndroidPlatform(),
            deviceInfo: FakeAndroidDeviceInfoPlugin(
              version: FakeAndroidBuildVersion(
                release: 'beta',
                sdkInt: 12,
              ),
            ),
            buildInfo: FakeBuildInfo(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('beta'), findsOneWidget);
    });

    testWidgets('Should find stable when android and version.release stable', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: "FOO",
            color: Colors.amberAccent,
            platform: FakeAndroidPlatform(),
            deviceInfo: FakeAndroidDeviceInfoPlugin(
              version: FakeAndroidBuildVersion(
                release: 'stable',
                sdkInt: 12,
              ),
            ),
            buildInfo: FakeBuildInfo(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('stable'), findsOneWidget);
    });

    testWidgets('Should find 12 when android and version.sdkInt 12', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: "FOO",
            color: Colors.amberAccent,
            platform: FakeAndroidPlatform(),
            deviceInfo: FakeAndroidDeviceInfoPlugin(
              version: FakeAndroidBuildVersion(
                release: 'beta',
                sdkInt: 12,
              ),
            ),
            buildInfo: FakeBuildInfo(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('12'), findsOneWidget);
    });

    testWidgets('Should find 132 when android and version.sdkInt 132', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DeviceInfoDialog.internal(
            flavorName: "FOO",
            color: Colors.amberAccent,
            platform: FakeAndroidPlatform(),
            deviceInfo: FakeAndroidDeviceInfoPlugin(
              version: FakeAndroidBuildVersion(
                release: 'beta',
                sdkInt: 132,
              ),
            ),
            buildInfo: FakeBuildInfo(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('132'), findsOneWidget);
    });

  });
}

class FakeBuildInfo extends Fake implements BuildInfo {
  final BuildMode buildMode;
  FakeBuildInfo({this.buildMode = BuildMode.debug});

  @override
  BuildMode currentBuildMode() => buildMode;
}

class FakeAndroidPlatform extends Fake implements PlatformWrapper {
  @override
  bool get isAndroid => true;

  @override
  bool get isIOS => false;
}

class FakeIOSPlatform extends Fake implements PlatformWrapper {
  @override
  bool get isAndroid => false;

  @override
  bool get isIOS => true;
}

class FakeIosDeviceInfoPlugin extends Fake implements DeviceInfoPlugin {
  final bool isPhysicalDevice;
  final String model;
  final String name;
  final String systemName;
  final String systemVersion;

  FakeIosDeviceInfoPlugin({
    this.isPhysicalDevice = false,
    this.model = 'model',
    this.name = 'name',
    this.systemName = 'systemName',
    this.systemVersion = 'systemVersion',
  });

  @override
  Future<IosDeviceInfo> get iosInfo async => Future.value(
    FakeIosDeviceInfo(
      isPhysicalDevice: isPhysicalDevice,
      model: model,
      name: name,
      systemName: systemName,
      systemVersion: systemVersion,
    ),
  );
}

class FakeAndroidDeviceInfoPlugin extends Fake implements DeviceInfoPlugin {
  final bool isPhysicalDevice;
  final String model;
  final String manufacturer;
  final AndroidBuildVersion version;

  FakeAndroidDeviceInfoPlugin({
    this.isPhysicalDevice = false,
    this.model = 'model',
    this.manufacturer = 'manufacturer',
    version,
  }) : this.version = version ?? FakeAndroidBuildVersion(
    release: 'fab_release',
    sdkInt: 0,
  );

  @override
  Future<AndroidDeviceInfo> get androidInfo async => Future.value(
    FakeAndroidDeviceInfo(
      isPhysicalDevice: isPhysicalDevice,
      model: model,
      manufacturer: manufacturer,
      version: version,
    ),
  );
}

class FakeAndroidBuildVersion extends Fake implements AndroidBuildVersion {
  final String release;
  final int sdkInt;

  FakeAndroidBuildVersion({
    @required this.release,
    @required this.sdkInt,
  });
}

class FakeAndroidDeviceInfo extends Fake implements AndroidDeviceInfo {
  final bool isPhysicalDevice;
  final String model;
  final String manufacturer;
  final AndroidBuildVersion version;

  FakeAndroidDeviceInfo({
    @required this.isPhysicalDevice,
    @required this.model,
    @required this.manufacturer,
    @required this.version,
  });
}

class FakeIosDeviceInfo extends Fake implements IosDeviceInfo {
  final bool isPhysicalDevice;
  final String model;
  final String name;
  final String systemName;
  final String systemVersion;

  FakeIosDeviceInfo({
    @required this.isPhysicalDevice,
    @required this.model,
    @required this.name,
    @required this.systemName,
    @required this.systemVersion,
  });
}
