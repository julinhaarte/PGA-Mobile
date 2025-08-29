import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

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
        'key': 'Dashboard',
        'title': 'Dashboard',
        'icon': Icons.dashboard,
        'activeIcon': Icons.dashboard,
      },
      {
        'key': 'Projects',
        'title': 'Projetos',
        'icon': Icons.folder,
        'activeIcon': Icons.folder,
      },
      {
        'key': 'CreateProject',
        'title': 'Criar',
        'icon': Icons.add_circle,
        'activeIcon': Icons.add_circle,
      },
      {
        'key': 'Settings',
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
            color: Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, -2),
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
                  onTap: () => onNavigate(route['key']),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isActive ? route['activeIcon'] : route['icon'],
                          size: 24,
                          color: isActive ? AppTheme.primaryColor : const Color(0xFF666666),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          route['title'],
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                            color: isActive ? AppTheme.primaryColor : const Color(0xFF666666),
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
