import 'package:flutter_test/flutter_test.dart';
import 'package:flavor_banner/services/string_utils.dart';

enum TestEnum {
  FOO,
  BAR,
  FOOBAR,
}

void main() {
  test('Should return FOO as a string', () {
    // Given
    var value = TestEnum.FOO;

    // When
    var name = StringUtils.enumName(value);

    // Then
    expect(name, 'FOO');
  });

  test('Should return FOOBAR as a string', () {
    // Given
    var value = TestEnum.FOOBAR;

    // When
    var name = StringUtils.enumName(value);

    // Then
    expect(name, 'FOOBAR');
  });
}