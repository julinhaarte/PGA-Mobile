import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'local_db.dart';
import 'auth_storage.dart';
import 'dart:convert';

class SyncService {
  final LocalDB _db = LocalDB();

  // Simple sync: read queue and try to send
  Future<void> trySyncAll(String baseUrl) async {
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) return;

    final token = await AuthStorage.readToken();
    final queue = await _db.getSyncQueue();
    for (final item in queue) {
      try {
        final endpoint = item['endpoint'] as String;
        final method = item['method'] as String;
        final body = item['body'] as String?;
        final id = item['id'] as int;
        final localRef = item['local_ref'] as String?;

        final headers = <String, String>{'Content-Type': 'application/json'};
        if (token != null) headers['Authorization'] = 'Bearer $token';

        late http.Response res;
        final url = '$baseUrl${endpoint.startsWith('/') ? '' : '/'}$endpoint';

        if (method.toUpperCase() == 'POST') {
          res = await http.post(Uri.parse(url), headers: headers, body: body);
        } else if (method.toUpperCase() == 'PUT') {
          res = await http.put(Uri.parse(url), headers: headers, body: body);
        } else if (method.toUpperCase() == 'DELETE') {
          res = await http.delete(Uri.parse(url), headers: headers);
        } else {
          // Unsupported - remove to avoid infinite loop
          await _db.removeSyncItem(id);
          continue;
        }

        if (res.statusCode >= 200 && res.statusCode < 300) {
          // success -> remove from queue
          // if POST created a resource and we have local_ref, map ids
          try {
            final respJson = res.body.isNotEmpty ? json.decode(res.body) : null;
            if (localRef != null && respJson != null) {
              // tentar extrair id: considerar 'id', 'project_id', 'pessoa_id' ou Prisma PK 'acao_projeto_id'
              final serverId = respJson['id'] ?? respJson['project_id'] ?? respJson['pessoa_id'] ?? respJson['acao_projeto_id'];
              if (serverId != null) {
                // serverId pode vir como int ou string - tentar converter
                int? parsedId;
                if (serverId is int) parsedId = serverId;
                else if (serverId is String) parsedId = int.tryParse(serverId);

                if (parsedId != null) {
                  await _db.updateProjectServerId(localRef, parsedId);
                }
              }
            }
          } catch (e) {
            // ignore parsing errors
          }

          await _db.removeSyncItem(id);
        } else {
          // keep in queue, maybe retry later
          // optionally add retry count logic
        }
      } catch (e) {
        // network or parse error - keep item
      }
    }
  }
}
