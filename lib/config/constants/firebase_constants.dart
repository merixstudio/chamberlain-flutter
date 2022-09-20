class FirebaseConstants {
  const FirebaseConstants._();

  static FirebaseCollections get collections => FirebaseCollections();
  static FirebaseKeys get keys => FirebaseKeys();
}

class FirebaseCollections {
  String get calendars => 'calendars';
  String get events => 'events';
  String get rooms => 'rooms';
  String get devices => 'devices';
}

class FirebaseKeys {
  String get id => 'id';
  String get startDateTime => 'start.dateTime';
  String get location => 'location';
}
