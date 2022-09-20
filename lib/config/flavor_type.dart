enum FlavorType {
  dev('dev'),
  prod('prod');

  const FlavorType(this.value);

  factory FlavorType.fromValue(String value) {
    return values.firstWhere((e) => e.value == value);
  }

  final String value;
}
