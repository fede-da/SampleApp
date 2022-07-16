import 'package:models/models.dart';

class UserRepository {
  User? _user;

  User? getUser() {
    if (_user != null) return _user;
    return User.empty;
  }

  void setUser(User user) => _user = user;

  void deleteCurrentUserAfterLogout() => _user = null;
}
