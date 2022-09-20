import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:collection/collection.dart';

@injectable
class NetworkUtil {
  const NetworkUtil();

  Future<String> addressIP() async {
    final Map<String, String> addresses = await adressIPs();
    return addresses.entries.map((address) => '${address.key}: ${address.value}').join('\n');
  }

  Future<Map<String, String>> adressIPs() async {
    final List<NetworkInterface> networkList = await NetworkInterface.list();
    final Map<String, String> ips = {};
    for (var element in networkList) {
      ips[element.name] = element.addresses.firstOrNull?.address ?? '';
    }
    return ips;
  }
}
