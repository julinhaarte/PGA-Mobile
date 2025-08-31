import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BottomNavigation extends StatelessWidget {
  final String currentRoute;
  final Function(String) onNavigate;

  const BottomNavigation({
    super.key,
    required this.currentRoute,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final routes = [
      {
        'key': '/dashboard',
        'title': 'Dashboard',
        'icon': Icons.dashboard,
        'activeIcon': Icons.dashboard,
      },
      {
        'key': '/projects',
        'title': 'Projetos',
        'icon': Icons.folder,
        'activeIcon': Icons.folder,
      },
      {
        'key': '/create-project',
        'title': 'Criar',
        'icon': Icons.add_circle,
        'activeIcon': Icons.add_circle,
      },
      {
        'key': '/settings',
        'title': 'Config',
        'icon': Icons.settings,
        'activeIcon': Icons.settings,
      },
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.white,
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 70,
          child: Row(
            children: routes.map((route) {
              final isActive = route['key'] == currentRoute;
              return Expanded(
                child: InkWell(
                  onTap: () => onNavigate(route['key'] as String),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isActive
                              ? route['activeIcon'] as IconData
                              : route['icon'] as IconData,
                          size: 24,
                          color: isActive ? AppTheme.primaryColor : const Color.fromARGB(255, 102, 102, 102),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          route['title'] as String,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                            color: isActive ? AppTheme.primaryColor : const Color.fromARGB(255, 104, 104, 104),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
