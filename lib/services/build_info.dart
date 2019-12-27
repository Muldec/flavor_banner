/// The different build mode available on flutter apps
enum BuildMode {
  debug,
  profile,
  release,
}

/// Devices related utility methods
class BuildInfo {
  /// Help us identify in which [BuildMode] we’re running,
  BuildMode currentBuildMode() {
    if (isRelease()) {
      return BuildMode.release;
    }

    if (isDebug()) {
      return BuildMode.debug;
    }

    return BuildMode.profile;
  }

  /// returns `true` if we detect that we are running a RELEASE version
  bool isRelease() => const bool.fromEnvironment('dart.vm.product');

  /// returns `true` if we detect that we are running a DEBUG version
  ///
  /// if we’re able to run and validate an assert() we’re on DEBUG
  /// since assert only runs on DEBUG
  bool isDebug() {
    var result = false;
    assert(() {
      result = true;
      return true;
    }());
    return result;
  }
}
