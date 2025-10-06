import 'dart:convert';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/project_card.dart';
import '../widgets/bottom_navigation.dart';
import '../services/local_db.dart';
import '../services/sync_service.dart';
import 'package:http/http.dart' as http;

const BACKEND_BASE = 'http://10.0.2.2:3000'; // ajustar conforme emulador/dispositivo

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  String _selectedStatus = 'all';
  String _searchQuery = '';

  final LocalDB _localDb = LocalDB();
  final SyncService _sync = SyncService();
  List<Map<String, dynamic>> _projects = [];

  final List<Map<String, String>> _statusFilters = [
    {'label': 'Todos', 'value': 'all'},
    {'label': 'Em andamento', 'value': 'em andamento'},
    {'label': 'Concluído', 'value': 'concluído'},
    {'label': 'Atrasado', 'value': 'atrasado'},
  ];

  List<Map<String, dynamic>> get _filteredProjects {
    return _projects.where((project) {
      final matchesStatus = _selectedStatus == 'all' || 
                           project['status'].toLowerCase() == _selectedStatus;
      final matchesSearch = _searchQuery.isEmpty || 
                           project['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
                           project['responsible'].toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesStatus && matchesSearch;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _loadLocalProjects();
    // tentar sincronizar em background
    _sync.trySyncAll(BACKEND_BASE).then((_) => _loadLocalProjects()).catchError((e) => debugPrint('sync error: $e'));
  }

  Future<void> _loadLocalProjects() async {
    final rows = await _localDb.getProjects();
    setState(() {
      _projects = rows.map((r) {
        final data = r['data'] as String;
        try {
          final parsed = Map<String, dynamic>.from(jsonDecode(data));
          return parsed;
        } catch (_) {
          return {'id': r['local_id'] ?? r['id'].toString(), 'name': data};
        }
      }).toList();
    });
  }

  Future<void> _onRefresh() async {
    // tentar sync (enviar fila)
    await _sync.trySyncAll(BACKEND_BASE);

    // tentar buscar a lista atual do backend e atualizar cache local
    try {
      final resp = await http.get(Uri.parse('$BACKEND_BASE/project1'));
      if (resp.statusCode == 200) {
        final List<dynamic> data = jsonDecode(resp.body);
        // salvar cada projeto no local DB (substituir cache simplificado)
        for (final p in data) {
          await _localDb.saveProject(jsonEncode(p), localId: p['codigo_projeto']?.toString());
        }
        await _loadLocalProjects();
        return;
      }
    } catch (e) {
      debugPrint('Erro ao buscar projetos do backend: $e');
    }

    // fallback: recarregar local
    await _loadLocalProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Projetos'),
      ),
      body: Column(
        children: [
          // Filtros e Busca
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Barra de Busca
                TextField(
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: InputDecoration(
                    hintText: 'Buscar projetos...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () => setState(() => _searchQuery = ''),
                          )
                        : null,
                  ),
                ),

                const SizedBox(height: 16),

                // Filtros de Status
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _statusFilters.map((filter) {
                      final isSelected = filter['value'] == _selectedStatus;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(filter['label']!),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedStatus = filter['value']!;
                            });
                          },
                          backgroundColor: Colors.white,
                          selectedColor: AppTheme.primaryColor,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : AppTheme.textPrimaryColor,
                          ),
                          side: isSelected ? null : BorderSide.none,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          // Lista de Projetos
          Expanded(
            child: _filteredProjects.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Nenhum projeto encontrado',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _filteredProjects.length,
                      itemBuilder: (context, index) {
                        final project = _filteredProjects[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: ProjectCard(
                            project: project,
                            onTap: () {
                              // Navegar para detalhes do projeto
                            },
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),

      // Navegação inferior
      bottomNavigationBar: BottomNavigation(
        currentRoute: '/projects',
        onNavigate: (route) {
          if (route == '/projects') return;
          context.go(route);
        },
      ),
    );
  }
}
