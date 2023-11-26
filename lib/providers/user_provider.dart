import 'package:flutter/cupertino.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier{

  User _user = User(
      id: '',
      name: '',
      username: '',
      email: '',
      mobno: 0,
      birthDate: '',
      password: '',
      token: '',
      bio: ''
  );

  User get user => _user;

  void setUser(String user){
    _user = User.fromJson(user);
    notifyListeners();
  }

}