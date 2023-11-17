import 'package:first_flutter_project/models/user.dart';

extension UserList on List<User> {
  User findUserById(int id) {
    return firstWhere((user) => user.id == id);
  }
}
