import 'package:flutter/foundation.dart';
import 'package:easflow_v1/Controller/db_new.dart';
import 'package:easflow_v1/Model/user_models.dart';

class RealtimeDataController extends ChangeNotifier {
  // DatabaseHelper instance
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  //USER
  // Get all users
  List<User> _users = [];
  List<User> get users => _users;

  Future<void> getAllUsers() async {
    notifyListeners();
  }

  // Get a user by ID
  User? _user;
  User? get user => _user;

  Future<void> getUser(int userId) async {
    _user = await _databaseHelper.getUser(userId);
    notifyListeners();
  }

  // Add a new user
  Future<int> addUser(User user) async {
    final insertedId = await _databaseHelper.addUser(user);
    await getAllUsers(); // Refresh user list
    return insertedId;
  }

  // Edit a user information
  Future<void> editUser(int userId, String name, String image) async {
    await _databaseHelper.editUser(userId, image, name);
    await getAllUsers(); // Refresh user list
  }

  // Delete a user
  Future<void> deleteUser(int id) async {
    await _databaseHelper.deleteUser(id);
    await getAllUsers(); // Refresh user list
  }
}
