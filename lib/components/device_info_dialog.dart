import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

import 'package:flavor_banner/services/build_info.dart';
import 'package:flavor_banner/services/platform_wrapper.dart';
import 'package:flavor_banner/services/string_utils.dart';

/// Widget that display all information related on a device
class DeviceInfoDialog extends StatelessWidget {
  /// The color that must be used to paint the title of the Dialog
  final Color color;

  /// The name of the flavor to display in the Dialog
  final String flavorName;

  final PlatformWrapper platform;

  final DeviceInfoPlugin deviceInfo;

  final BuildInfo buildInfo;

  /// Creates the Device Info Dialog
  DeviceInfoDialog({this.flavorName, this.color})
      : assert(color != null),
        this.platform = PlatformWrapper(),
        this.deviceInfo = DeviceInfoPlugin(),
        this.buildInfo = BuildInfo();

  /// Creates the Device Info Dialog by providing a [PlatformWrapper] and
  /// a [BuildInfo]
  @visibleForTesting
  const DeviceInfoDialog.internal({
    this.flavorName,
    this.color,
    @required this.platform,
    @required this.deviceInfo,
    @required this.buildInfo
  }) : assert(color != null);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.only(bottom: 10.0),
      title: Container(
        padding: const EdgeInsets.all(15.0),
        color: color,
        child: Text('Device Info', style: TextStyle(color: Colors.white)),
      ),
      titlePadding: const EdgeInsets.all(0),
      content: _getContent(),
    );
  }

  Widget _getContent() {
    if (platform.isAndroid) {
      return _androidContent();
    }

    if (platform.isIOS) {
      return _iOSContent();
    }

    return const Text('You\'re neither on Android nor iOS');
  }

  Widget _iOSContent() {
    return FutureBuilder(
      future: deviceInfo.iosInfo,
      builder: (context, AsyncSnapshot<IosDeviceInfo> snapshot) {
        if (!snapshot.hasData) return const SizedBox();

        final device = snapshot.data;
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildTile('Flavor: ', flavorName),
              _buildTile('Build mode: ',
                  StringUtils.enumName(buildInfo.currentBuildMode())),
              _buildTile(
                  'Physical device?: ', device.isPhysicalDevice.toString()),
              _buildTile('Device: ', device.name),
              _buildTile('Model: ', device.model),
              _buildTile('System name: ', device.systemName),
              _buildTile('System version: ', device.systemVersion),
            ],
          ),
        );
      },
    );
  }

  Widget _androidContent() {
    return FutureBuilder(
      future: deviceInfo.androidInfo,
      builder: (context, AsyncSnapshot<AndroidDeviceInfo> snapshot) {
        if (!snapshot.hasData) return const SizedBox();

        final device = snapshot.data;
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildTile('Flavor: ', flavorName),
              _buildTile('Build mode: ',
                  StringUtils.enumName(buildInfo.currentBuildMode())),
              _buildTile(
                  'Physical device?: ', device.isPhysicalDevice.toString()),
              _buildTile('Manufacturer: ', device.manufacturer),
              _buildTile('Model: ', device.model),
              _buildTile('Android version: ', device.version.release),
              _buildTile('Android SDK: ', device.version.sdkInt.toString()),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTile(String key, String value) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          Text(key, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
