import 'package:injectable/injectable.dart';
import 'package:kiosk_mode/kiosk_mode.dart';

@injectable
class KioskModeUtil {
  Future<bool> isEnabled() async {
    final KioskMode mode = await getKioskMode();
    return _mapKioskMode(mode);
  }

  Stream<bool> watchStatus({
    Duration androidQueryPeriod = const Duration(
      seconds: 1,
    ),
  }) {
    return watchKioskMode(
      androidQueryPeriod: androidQueryPeriod,
    ).map(
      (mode) => _mapKioskMode(mode),
    );
  }

  Future<bool> enable() {
    return startKioskMode();
  }

  Future<void> disable() {
    return stopKioskMode();
  }

  bool _mapKioskMode(KioskMode mode) {
    switch (mode) {
      case KioskMode.enabled:
        return true;
      case KioskMode.disabled:
        return false;
    }
  }
}
