import 'package:flutter/material.dart';

import 'package:flavor_banner/components/device_info_dialog.dart';
import 'package:flavor_banner/components/flavor_config.dart';

/// Widget that displays a Banner to show the current build flavor
class FlavorBanner extends StatelessWidget {
  /// The child of this widget (often the main scaffold)
  final Widget child;

  /// The flavor related to the banner
  final FlavorConfig flavorConfig;

  /// Creates the widget by providing its [child] (often the main scaffold)
  /// the [flavorConfig] and the [bannerConfig]
  const FlavorBanner(
      {@required this.child, @required this.flavorConfig})
      : assert(child != null),
        assert(flavorConfig != null);

  @override
  Widget build(BuildContext context) {
    // Do not add a banner when production
    if (flavorConfig.isProduction()) return child;

    return Stack(
      children: <Widget>[child, _buildBanner(context)],
    );
  }

  Widget _buildBanner(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Container(
        width: 50,
        height: 50,
        child: FlavorBannerPaint(config: flavorConfig),
      ),
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return DeviceInfoDialog(
              flavorName: flavorConfig.name,
              color: flavorConfig.color,
            );
          },
        );
      },
    );
  }
}

class FlavorBannerPaint extends StatelessWidget {
  const FlavorBannerPaint({
    Key key,
    @required this.config,
  }) : super(key: key);

  final FlavorConfig config;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BannerPainter(
        message: config.name,
        textDirection: Directionality.of(context),
        layoutDirection: Directionality.of(context),
        location: BannerLocation.topStart,
        color: config.color,
      ),
    );
  }
}