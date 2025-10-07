import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'auth_storage.dart';

class AuthProvider extends ChangeNotifier {
  final String baseUrl;
  AuthProvider({required this.baseUrl});

  String? _token;
  String? _refreshToken;
  Map<String, dynamic>? _user;

  String? get token => _token;
  Map<String, dynamic>? get user => _user;
  bool get isAuthenticated => _token != null;

  Future<void> loadFromStorage() async {
    _token = await AuthStorage.readToken();
    _refreshToken = await AuthStorage.readRefreshToken();
    if (_token != null) {
      // try to validate with backend
      try {
        final res = await http.get(Uri.parse('\$baseUrl/auth/me'), headers: {'Authorization': 'Bearer \\$_token'});
        if (res.statusCode == 200) {
          _user = jsonDecode(res.body) as Map<String, dynamic>;
        } else {
          // invalid token - try refresh
          final refreshed = await tryRefresh();
          if (!refreshed) {
            await logout();
          }
        }
      } catch (_) {
        // offline: keep token in memory and allow offline mode
      }
    }
    notifyListeners();
  }

  Future<void> setToken(String access, {String? refresh, Map<String,dynamic>? userData}) async {
    _token = access;
    if (refresh != null) {
      _refreshToken = refresh;
      await AuthStorage.saveRefreshToken(refresh);
    }
    await AuthStorage.saveToken(access);
    if (userData != null) _user = userData;
    notifyListeners();
  }

  Future<void> logout() async {
    _token = null;
    _refreshToken = null;
    _user = null;
    await AuthStorage.removeToken();
    await AuthStorage.removeRefreshToken();
    notifyListeners();
  }

  Future<bool> tryRefresh() async {
    if (_refreshToken == null) return false;
    try {
      final res = await http.post(Uri.parse('\$baseUrl/auth/refresh'), body: {'refresh_token': _refreshToken});
      if (res.statusCode == 200) {
        final json = jsonDecode(res.body) as Map<String, dynamic>;
        final newAccess = json['access_token'] as String?;
        if (newAccess != null) {
          _token = newAccess;
          await AuthStorage.saveToken(newAccess);
          // optionally revalidate me
          try {
            final me = await http.get(Uri.parse('\$baseUrl/auth/me'), headers: {'Authorization': 'Bearer \\$_token'});
            if (me.statusCode == 200) _user = jsonDecode(me.body) as Map<String, dynamic>;
          } catch (_) {}
          notifyListeners();
          return true;
        }
      }
    } catch (_) {}
    return false;
  }
}
