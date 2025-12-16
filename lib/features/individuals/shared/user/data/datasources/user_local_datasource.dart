import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:graduation_project/features/individuals/shared/user/domain/entities/user_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';


@injectable
class UserLocalDataSource {
  final SharedPreferences prefs;
  static const String _storageKey = 'user_entity_data';

  UserLocalDataSource(this.prefs);

  Future<UserEntity?> getLastUser() async {
    final jsonString = prefs.getString(_storageKey);
    debugPrint("getting last user");
    
    if (jsonString != null) {
      try {
        debugPrint("decoding");
        return UserEntity.fromJson(jsonDecode(jsonString));
      } catch (e) {
        
        debugPrint("Local data corrupted. Clearing cache. Error: $e");
        await prefs.remove(_storageKey); 
        return null;
      }
    }
    return null;
  }

  Future<void> cacheUser(UserEntity user) async {
    await prefs.setString(_storageKey, jsonEncode(user.toJson()));
  }
}