import 'package:collection/collection.dart';

extension ListExtension<T> on List<T> {
  Map<int, List<T>> groupListsByCondition(bool Function(T? previous, T element) condition) {
    var key = 0;
    var result = <int, List<T>>{};
    forEachIndexed((index, element) {
      key = condition(index > 0 ? this[index - 1] : null, element) ? key : key + 1;
      (result[key] ??= []).add(element);
    });
    return result;
  }
}
