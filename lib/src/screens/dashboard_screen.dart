import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/stats_card.dart';
import '../widgets/project_card.dart';
import '../widgets/bottom_navigation.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _activeTab = 'overview';

  // Dados mockados
  final List<Map<String, dynamic>> _mockStats = [
    {'title': 'Total de Projetos', 'value': '12', 'icon': '📊', 'color': const Color(0xFF4CAF50)},
    {'title': 'Em Andamento', 'value': '8', 'icon': '🚀', 'color': const Color(0xFF2196F3)},
    {'title': 'Concluídos', 'value': '3', 'icon': '✅', 'color': const Color(0xFF4CAF50)},
    {'title': 'Atrasados', 'value': '1', 'icon': '⚠️', 'color': const Color(0xFFFF9800)},
  ];

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
  ];

  Widget _buildOverview() {
    return Column(
      children: [
        // Cards de Estatísticas
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.5,
          ),
          itemCount: _mockStats.length,
          itemBuilder: (context, index) {
            final stat = _mockStats[index];
            return StatsCard(
              title: stat['title'],
              value: stat['value'],
              icon: stat['icon'],
              color: stat['color'],
            );
          },
        ),

        const SizedBox(height: 24),

        // Card da Instituição
        Card(
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(20),
            child: const Column(
              children: [
                Text(
                  'IDENTIFICAÇÃO DA UNIDADE',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _InfoItem(label: 'Código', value: 'F301'),
                    _InfoItem(label: 'Unidade', value: 'Fatec Votorantim'),
                    _InfoItem(label: 'Diretor(a)', value: 'Prof. Dr. Mauro Tomazela'),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Projetos em Destaque
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Projetos em Destaque',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimaryColor,
            ),
          ),
        ),

        const SizedBox(height: 16),

        ..._mockProjects.take(2).map((project) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ProjectCard(
            project: project,
            onTap: () => context.go('/projects'),
          ),
        )),
      ],
    );
  }

  Widget _buildProjects() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Todos os Projetos',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimaryColor,
            ),
          ),
        ),

        const SizedBox(height: 16),

        ..._mockProjects.map((project) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ProjectCard(
            project: project,
            onTap: () => context.go('/projects'),
          ),
        )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Dashboard PGA 2025'),
      ),
      body: Column(
        children: [
          // Tabs
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => _activeTab = 'overview'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _activeTab == 'overview' 
                          ? AppTheme.primaryColor 
                          : Colors.white,
                      foregroundColor: _activeTab == 'overview' 
                          ? Colors.white 
                          : AppTheme.primaryColor,
                    ),
                    child: const Text('Visão Geral'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => _activeTab = 'projects'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _activeTab == 'projects' 
                          ? AppTheme.primaryColor 
                          : const Color.fromARGB(255, 255, 255, 255),
                      foregroundColor: _activeTab == 'projects' 
                          ? Colors.white 
                          : AppTheme.primaryColor,
                    ),
                    child: const Text('Projetos'),
                  ),
                ),
              ],
            ),
          ),

          // Conteúdo
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _activeTab == 'overview' ? _buildOverview() : _buildProjects(),
            ),
          ),
        ],
      ),

      // FAB para criar projeto
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/create-project'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Novo Projeto'),
      ),

      // Navegação inferior
      bottomNavigationBar: BottomNavigation(
        currentRoute: '/dashboard',
        onNavigate: (route) {
          if (route == '/dashboard') return;
          context.go(route);
        },
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;

  const _InfoItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
