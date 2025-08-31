import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/project_card.dart';
import '../widgets/bottom_navigation.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  String _selectedStatus = 'all';
  String _searchQuery = '';

  final List<Map<String, dynamic>> _mockProjects = [
    {
      'id': '1',
      'name': 'Sistema de Gestão Acadêmica',
      'progress': 75,
      'status': 'Em andamento',
      'deadline': '15/03/2025',
      'responsible': 'Ana Silva',
    },
    {
      'id': '2',
      'name': 'Modernização Laboratórios',
      'progress': 45,
      'status': 'Em andamento',
      'deadline': '28/02/2025',
      'responsible': 'Carlos Santos',
    },
    {
      'id': '3',
      'name': 'Portal de Comunicação',
      'progress': 20,
      'status': 'Em andamento',
      'deadline': '10/02/2025',
      'responsible': 'Maria Oliveira',
    },
    {
      'id': '4',
      'name': 'Sistema de Biblioteca',
      'progress': 100,
      'status': 'Concluído',
      'deadline': '01/01/2025',
      'responsible': 'João Silva',
    },
    {
      'id': '5',
      'name': 'Manutenção de Equipamentos',
      'progress': 30,
      'status': 'Atrasado',
      'deadline': '20/01/2025',
      'responsible': 'Pedro Santos',
    },
  ];

  final List<Map<String, String>> _statusFilters = [
    {'label': 'Todos', 'value': 'all'},
    {'label': 'Em andamento', 'value': 'em andamento'},
    {'label': 'Concluído', 'value': 'concluído'},
    {'label': 'Atrasado', 'value': 'atrasado'},
  ];

  List<Map<String, dynamic>> get _filteredProjects {
    return _mockProjects.where((project) {
      final matchesStatus = _selectedStatus == 'all' || 
                           project['status'].toLowerCase() == _selectedStatus;
      final matchesSearch = _searchQuery.isEmpty || 
                           project['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
                           project['responsible'].toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesStatus && matchesSearch;
    }).toList();
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
                : ListView.builder(
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
