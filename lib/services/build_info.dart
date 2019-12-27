/// The different build mode available on flutter apps
enum BuildMode {
  DEBUG,
  PROFILE,
  RELEASE,
}

/// Devices related utility methods
class BuildInfo {
  /// Help us identify in which [BuildMode] we’re running,
  BuildMode currentBuildMode() {
    if (isRelease()) {
      return BuildMode.RELEASE;
    }

    if (isDebug()) {
      return BuildMode.DEBUG;
    }

    return BuildMode.PROFILE;
  }

  /// returns `true` if we detect that we are running a RELEASE version
  bool isRelease() => bool.fromEnvironment('dart.vm.product');

  /// returns `true` if we detect that we are running a DEBUG version
  ///
  /// if we’re able to run and validate an assert() we’re on DEBUG
  /// since assert only runs on DEBUG
  bool isDebug() {
    bool result = false;
    assert(() {
      result = true;
      return true;
    }());
    return result;
  }
}
