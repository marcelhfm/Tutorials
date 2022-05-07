import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/domain/entities/user.dart';

import '../../domain/entities/id.dart';

extension FirebaseUserMapper on User {
  CustomUser toDomain() {
    return CustomUser(id: UniqueId.fromUniqueString(uid));
  }
}
