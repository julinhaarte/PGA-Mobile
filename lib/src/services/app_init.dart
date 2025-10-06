import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'local_db.dart';
import 'auth_storage.dart';
import 'sync_service.dart';

class AppInit {
  final LocalDB _db = LocalDB();
  final SyncService _sync = SyncService();

  Future<void> initialize(String baseUrl) async {
    // 1) check token and validate
    final token = await AuthStorage.readToken();
    if (token != null) {
      try {
        final res = await http.get(
          Uri.parse('$baseUrl/auth/me'),
          headers: {'Authorization': 'Bearer $token'},
        );
        if (res.statusCode == 200) {
          // token válido - pode usar dados do usuário se necessário
        } else {
          // token inválido - remover
          await AuthStorage.removeToken();
        }
      } catch (_) {
        // sem conexão - manter token local e tentar validar depois
      }
    }

    // 2) try to sync pending operations when online
    Connectivity().onConnectivityChanged.listen((event) async {
      if (event != ConnectivityResult.none) {
        await _sync.trySyncAll(baseUrl);
      }
    });

    // 3) optionally fetch and cache lookups
    try {
      final res = await http.get(Uri.parse('$baseUrl/sync/lookup'));
      if (res.statusCode == 200) {
        final json = jsonDecode(res.body) as Map<String, dynamic>;
        // assume json contains lists by type: { eixos: [...], temas: [...], unidades: [...] }
        if (json.containsKey('eixos')) {
          await _db.clearLookup('eixo');
          for (final item in json['eixos']) {
            await _db.insertLookup('eixo', jsonEncode(item), serverId: item['id']);
          }
        }
        if (json.containsKey('temas')) {
          await _db.clearLookup('tema');
          for (final item in json['temas']) {
            await _db.insertLookup('tema', jsonEncode(item), serverId: item['id']);
          }
        }
      }
    } catch (_) {
      // sem conexão - seguir com dados locais
    }
  }
}
