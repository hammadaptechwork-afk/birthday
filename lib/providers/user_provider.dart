import 'package:flutter/material.dart';

class User {
  final String id;
  final String name;
  final String email;
  final bool isAdmin;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.isAdmin = false,
  });
}

class UserProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isAdmin = false;

  User? get currentUser => _currentUser;
  bool get isAdmin => _isAdmin;
  bool get isLoggedIn => _currentUser != null;

  void login(User user) {
    _currentUser = user;
    _isAdmin = user.isAdmin;
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    _isAdmin = false;
    notifyListeners();
  }

  void switchToAdminMode() {
    _isAdmin = true;
    notifyListeners();
  }

  void switchToUserMode() {
    _isAdmin = false;
    notifyListeners();
  }
}