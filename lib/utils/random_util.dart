import 'dart:math';

import 'package:injectable/injectable.dart';

@injectable
class RandomUtil {
  final Random _random = Random.secure();

  int randomInt({
    int min = 0,
    int max = 10,
  }) {
    return _random.nextInt(max) + min;
  }

  bool randomBool() {
    return _random.nextBool();
  }
}
