import 'package:flavor_banner/services/build_info.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should return BuildMode.debug as currentBuildMode', () {
    // Given
    var buildInfo = BuildInfo();

    // When
    var currentBuildMode = buildInfo.currentBuildMode();

    // Then
    expect(currentBuildMode, BuildMode.debug);
  });
}