part of 'app_dimensions.dart';

class _Radius {
  const _Radius();

  double get small => 8.0;
  double get normal => 16.0;
  double get big => 24.0;

  BorderRadius smallRadius() => BorderRadius.circular(small);
  BorderRadius normalRadius() => BorderRadius.circular(normal);
  BorderRadius bigRadius() => BorderRadius.circular(big);
}
