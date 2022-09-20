import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseMobule {
  @injectable
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
}
