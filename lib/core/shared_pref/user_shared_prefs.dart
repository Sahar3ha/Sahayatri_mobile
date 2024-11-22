import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/core/failure/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userSharedPrefsProvider = Provider<UserSharedPrefs>((ref) {
  return UserSharedPrefs();
});

class UserSharedPrefs {
  late SharedPreferences _sharedPreferences;
  // Set user token
  Future<Either<Failure, bool>> setUserToken(String token) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setString('token', token);
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Get user token
  Future<Either<Failure, String?>> getUserToken() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final token = _sharedPreferences.getString('token');
      return right(token);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Delete token
  Future<Either<Failure, bool>> deleteUserToken() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.remove('token');
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }



  String? getUserId() {
    return _sharedPreferences.getString('_id');
  }

  // Set user ID
  Future<Either<Failure, bool>> setUserId(String userId) async {
    try {
      await _sharedPreferences.setString('_id', userId);
      return right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<bool> setUser(Map<String, dynamic> user) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      String userDataString = jsonEncode(user);
      await _sharedPreferences.setString('user', userDataString);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>?> getUser() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      String? userDataString = _sharedPreferences.getString('user');

      if (userDataString == null || userDataString.isEmpty) {
        return null;
      }

      Map<String, dynamic> userData = jsonDecode(userDataString);
      return userData;
    } catch (e) {
      return null;
    }
  }



Future<void> setUserFirstName(String firstName) async {
  try {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final Map<String, dynamic> userData = {
      'firstName': firstName,
      // Add other user data as needed
    };

    // Save the user data to SharedPreferences
    await sharedPreferences.setString('userData', json.encode(userData));
  } catch (e) {
    // Handle exceptions if needed
    print('Error setting user first name: $e');
  }
}

  Future<String?> getUserFirstName() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final userData = await getUser();

      if (userData == null || userData.isEmpty) {
        return null;
      }

      return userData['firstName']; // Modify this line according to your user data structure
    } catch (e) {
      return null;
    }
  }
}
