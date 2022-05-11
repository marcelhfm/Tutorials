import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/errors/errors.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../injection.dart';

extension FireStoreExt on FirebaseFirestore {
  Future<DocumentReference> userDocument() async {
    final userOption = sl<AuthRepository>().getSignedInUser();
    final user = userOption.getOrElse(() => throw NotAuthenticatedError());

    return FirebaseFirestore.instance.collection("users").doc(user.id.value);
  }
}

extension DocumentReferenceExt on DocumentReference {
  CollectionReference<Map<String, dynamic>> get todoCollection =>
      collection("todo");
}
